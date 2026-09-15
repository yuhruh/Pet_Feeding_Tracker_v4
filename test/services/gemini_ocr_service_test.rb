require "test_helper"
require "minitest/mock"

class GeminiOcrServiceTest < ActiveSupport::TestCase
  # Records the request instead of calling Gemini.
  class FakeHTTP
    attr_accessor :use_ssl, :open_timeout, :write_timeout, :read_timeout
    attr_reader :sent_request

    def initialize(response)
      @response = response
    end

    def request(request)
      @sent_request = request
      @response
    end
  end

  FakeResponse = Struct.new(:code, :body)
  UserWithKey = Struct.new(:gemini_api_key)

  setup do
    @png = file_fixture("lab_report.png").to_s # a real binary PNG (test_avatar.png is base64 text)
  end

  test "sends the API key in a header, never in the URL" do
    body = { candidates: [ { content: { parts: [ { text: '{"crea": 1.2}' } ] } } ] }.to_json
    http = FakeHTTP.new(FakeResponse.new("200", body))

    result = Net::HTTP.stub(:new, http) do
      GeminiOcrService.new([ @png ], UserWithKey.new("secret-test-key")).call
    end

    assert_equal({ "crea" => 1.2 }, result)
    request = http.sent_request
    assert_equal URI.parse(GeminiOcrService::API_URL).request_uri, request.path
    assert_not_includes request.path, "secret-test-key"
    assert_not_includes request.path, "key="
    assert_equal "secret-test-key", request["x-goog-api-key"]
    assert_equal 10, http.open_timeout
  end

  test "labels each image with the type detected from its contents" do
    http = FakeHTTP.new(FakeResponse.new("200", { candidates: [ { content: { parts: [ { text: "{}" } ] } } ] }.to_json))
    renamed_png = Tempfile.new([ "report", ".jpg" ]) # a PNG whose name says JPEG
    renamed_png.binmode
    renamed_png.write(File.binread(@png))
    renamed_png.flush

    Net::HTTP.stub(:new, http) do
      GeminiOcrService.new([ renamed_png.path ], UserWithKey.new("k")).call
    end

    sent = JSON.parse(http.sent_request.body)
    assert_equal "image/png", sent.dig("contents", 0, "parts", 1, "inline_data", "mime_type")
  ensure
    renamed_png&.close!
  end

  test "does not contact Gemini when the upload is rejected" do
    Net::HTTP.stub(:new, ->(*) { flunk "Gemini must not be called" }) do
      result = GeminiOcrService.new([ @png ] * (GeminiOcrService::MAX_FILES + 1), UserWithKey.new("k")).call
      assert_equal I18n.t("services.gemini_ocr.too_many_files", max: GeminiOcrService::MAX_FILES), result[:error]
    end
  end

  test "upload_error accepts real images within the limits" do
    assert_nil GeminiOcrService.upload_error([ @png ])
    assert_nil GeminiOcrService.upload_error([ @png ] * GeminiOcrService::MAX_FILES)
  end

  test "upload_error rejects no files and too many files" do
    assert_equal I18n.t("services.gemini_ocr.no_files"), GeminiOcrService.upload_error([])
    assert_equal I18n.t("services.gemini_ocr.too_many_files", max: GeminiOcrService::MAX_FILES),
                 GeminiOcrService.upload_error([ @png ] * (GeminiOcrService::MAX_FILES + 1))
  end

  test "upload_error rejects a file over the size limit" do
    with_file_of_size(GeminiOcrService::MAX_FILE_SIZE + 1) do |big|
      assert_equal I18n.t("services.gemini_ocr.file_too_large", max: "10 MB"), GeminiOcrService.upload_error([ big ])
    end
  end

  test "upload_error rejects files that are too large together" do
    each_size = GeminiOcrService::MAX_TOTAL_SIZE / 2 + 1 # each under the per-file limit
    with_file_of_size(each_size) do |a|
      with_file_of_size(each_size) do |b|
        assert_equal I18n.t("services.gemini_ocr.total_too_large", max: "14 MB"), GeminiOcrService.upload_error([ a, b ])
      end
    end
  end

  test "upload_error rejects a non-image even when it is named like one" do
    fake = Tempfile.new([ "report", ".png" ])
    fake.write("exam_date,crea\n2026-01-01,1.2\n")
    fake.flush
    assert_equal I18n.t("services.gemini_ocr.unsupported_type"), GeminiOcrService.upload_error([ fake.path ])
  ensure
    fake&.close!
  end

  private
    # A sparse file: the right size without writing megabytes to disk.
    def with_file_of_size(bytes)
      file = Tempfile.new("upload")
      file.truncate(bytes)
      yield file.path
    ensure
      file&.close!
    end
end
