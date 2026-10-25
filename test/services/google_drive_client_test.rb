require "test_helper"
require "minitest/mock"

class GoogleDriveClientTest < ActiveSupport::TestCase
  # Records every request and replies with the queued responses, so nothing reaches Google.
  class FakeHTTP
    attr_accessor :use_ssl, :open_timeout, :read_timeout
    attr_reader :requests

    def initialize(responses)
      @responses = responses
      @requests = []
    end

    def request(request)
      @requests << request
      @responses.shift or raise "unexpected extra request to #{request.path}"
    end
  end

  FakeResponse = Struct.new(:code, :body)

  def ok(body) = FakeResponse.new("200", body.to_json)
  def token = ok(access_token: "access-123", expires_in: 3599)

  def with_http(*responses)
    http = FakeHTTP.new(responses)
    result = Net::HTTP.stub(:new, http) { yield }
    [ result, http.requests ]
  end

  test "asks Google only for the files the app creates, with a refresh token every time" do
    query = URI.decode_www_form(URI(GoogleDriveClient.authorize_url(redirect_uri: "https://example.com/drive_backup/callback", state: "abc")).query).to_h

    assert_equal "https://www.googleapis.com/auth/drive.file", query["scope"]
    assert_equal "offline", query["access_type"]
    assert_equal "consent", query["prompt"]
    assert_equal "abc", query["state"]
    assert_equal "https://example.com/drive_backup/callback", query["redirect_uri"]
  end

  test "exchange_code returns the refresh token" do
    token, requests = with_http(ok(refresh_token: "refresh-1", scope: GoogleDriveClient::SCOPE)) do
      GoogleDriveClient.exchange_code("code-1", redirect_uri: "https://example.com/cb")
    end

    assert_equal "refresh-1", token
    params = URI.decode_www_form(requests.first.body).to_h
    assert_equal [ "authorization_code", "code-1" ], params.values_at("grant_type", "code")
  end

  test "exchange_code refuses a token without Drive, when the user unticked it" do
    error = assert_raises(GoogleDriveClient::Error) do
      with_http(ok(refresh_token: "refresh-1", scope: "openid")) { GoogleDriveClient.exchange_code("code-1", redirect_uri: "x") }
    end
    assert_equal "drive_permission_missing", error.message
  end

  test "updates an existing file in place and takes it out of the trash" do
    id, requests = with_http(token, ok(id: "file-1")) do
      GoogleDriveClient.new("refresh-1").upload_csv(name: "Mochi.csv", csv: "date;amount\n", folder_id: "folder-1", file_id: "file-1")
    end

    assert_equal "file-1", id
    upload = requests.last
    assert_equal "PATCH", upload.method
    assert_equal "/upload/drive/v3/files/file-1", URI(upload.path).path
    assert_equal "Bearer access-123", upload["Authorization"]
    assert_includes upload.body, { name: "Mochi.csv", trashed: false }.to_json
    assert_includes upload.body, "date;amount"
  end

  test "creates the file in the folder when the old one was deleted" do
    id, requests = with_http(token, FakeResponse.new("404", { error: { message: "File not found" } }.to_json), ok(id: "file-2")) do
      GoogleDriveClient.new("refresh-1").upload_csv(name: "Mochi.csv", csv: "x", folder_id: "folder-1", file_id: "file-1")
    end

    assert_equal "file-2", id
    assert_equal "POST", requests.last.method
    assert_includes requests.last.body, '"parents":["folder-1"]'
  end

  test "a trashed or deleted folder doesn't count" do
    client = GoogleDriveClient.new("refresh-1")
    assert_not with_http(token, ok(trashed: true)) { client.folder?("folder-1") }.first
    assert_not with_http(FakeResponse.new("404", "{}")) { client.folder?("folder-1") }.first
    assert with_http(ok(trashed: false)) { client.folder?("folder-1") }.first
  end

  test "trash_file moves the file to the Drive trash, and a file already gone counts as done" do
    trashed, requests = with_http(token, ok(id: "file-1")) { GoogleDriveClient.new("refresh-1").trash_file("file-1") }

    assert trashed
    assert_equal "PATCH", requests.last.method
    assert_equal "/drive/v3/files/file-1", URI(requests.last.path).path
    assert_equal({ "trashed" => true }, JSON.parse(requests.last.body))
    assert with_http(token, FakeResponse.new("404", "{}")) { GoogleDriveClient.new("refresh-1").trash_file("gone") }.first
  end

  test "a revoked refresh token raises Unauthorized" do
    assert_raises(GoogleDriveClient::Unauthorized) do
      with_http(FakeResponse.new("400", { error: "invalid_grant" }.to_json)) { GoogleDriveClient.new("old").email }
    end
  end

  test "a network failure is a Drive error, so the job retries it" do
    http = FakeHTTP.new([])
    def http.request(*) = raise(Errno::ECONNRESET)

    error = assert_raises(GoogleDriveClient::Error) { Net::HTTP.stub(:new, http) { GoogleDriveClient.new("refresh-1").email } }
    assert_match "could not reach Google", error.message
  end
end
