require "test_helper"
require "minitest/mock"

# The photo-extraction endpoint rejects uploads Gemini shouldn't receive before
# calling it, and passes valid images through.
class HealthCheckOcrUploadTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as(users(:one))
    @pet = pets(:one)
  end

  test "the upload section states the limits before anything is uploaded" do
    get new_pet_health_check_url(@pet)
    assert_response :success

    hint = I18n.t("shared.ocr_auto_fill.description", max_files: GeminiOcrService::MAX_FILES,
                  max_file_size: human_size(GeminiOcrService::MAX_FILE_SIZE), max_total_size: human_size(GeminiOcrService::MAX_TOTAL_SIZE))
    assert_select "#ocr_upload_hint", text: hint
    assert_match(/5 images.*10 MB each, 14 MB in total/, hint)

    # the browser gets the same limits the server enforces
    assert_select "[data-controller='ocr-upload']" \
                  "[data-ocr-upload-max-files-value='#{GeminiOcrService::MAX_FILES}']" \
                  "[data-ocr-upload-max-file-size-value='#{GeminiOcrService::MAX_FILE_SIZE}']" \
                  "[data-ocr-upload-max-total-size-value='#{GeminiOcrService::MAX_TOTAL_SIZE}']"

    # sizes read "10 MB" in every language, never "10.0 MB".
    # with_locale restores the test thread's locale afterwards: the app sets
    # I18n.locale during the request, and it would otherwise leak into later tests.
    I18n.with_locale(I18n.locale) do
      get new_pet_health_check_url(@pet, locale: "zh-TW")
      assert_select "#ocr_upload_hint", text: /10 MB.*14 MB/
      assert_not_includes response.body, "10.0 MB"
    end
  end

  test "rejects a non-image even when the browser calls it image/png" do
    without_calling_gemini do
      post extract_data_pet_health_checks_url(@pet), params: { files: [ fixture_file_upload("trackers.csv", "image/png") ] }
    end
    assert_response :unprocessable_entity
    assert_equal I18n.t("services.gemini_ocr.unsupported_type"), response.parsed_body["error"]
  end

  test "rejects more images than the limit" do
    files = Array.new(GeminiOcrService::MAX_FILES + 1) { fixture_file_upload("lab_report.png", "image/png") }
    without_calling_gemini do
      post extract_data_pet_health_checks_url(@pet), params: { files: files }
    end
    assert_response :unprocessable_entity
    assert_equal I18n.t("services.gemini_ocr.too_many_files", max: GeminiOcrService::MAX_FILES), response.parsed_body["error"]
  end

  test "rejects a request with no files" do
    without_calling_gemini do
      post extract_data_pet_health_checks_url(@pet)
    end
    assert_response :unprocessable_entity
    assert_equal I18n.t("services.gemini_ocr.no_files"), response.parsed_body["error"]
  end

  test "passes valid images to Gemini and returns the extracted values" do
    received = nil
    fake_service = Object.new
    fake_service.define_singleton_method(:call) { { "crea" => 1.2 } }
    GeminiOcrService.stub(:new, ->(paths, user) { received = [ paths, user ]; fake_service }) do
      post extract_data_pet_health_checks_url(@pet), params: { files: [ fixture_file_upload("lab_report.png", "image/png") ] }
    end
    assert_response :success
    assert_equal({ "crea" => 1.2 }, response.parsed_body)
    assert_equal 1, received[0].size
    assert_equal users(:one), received[1]
  end

  private
    def human_size(bytes)
      GeminiOcrService.human_size(bytes)
    end

    def without_calling_gemini(&block)
      GeminiOcrService.stub(:new, ->(*) { flunk "Gemini must not be called" }, &block)
    end
end
