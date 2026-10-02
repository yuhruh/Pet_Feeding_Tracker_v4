require "test_helper"
require "minitest/mock"

# Firebase Cloud Messaging HTTP v1 (checkpoint I), with the HTTP calls stubbed:
# the signed access-token request, the message, and reading FCM's answers.
class FcmClientTest < ActiveSupport::TestCase
  KEY = OpenSSL::PKey::RSA.generate(2048)
  CREDENTIALS = { "project_id" => "pet-tracker-test", "client_email" => "fcm@pet-tracker-test.iam.gserviceaccount.com",
                  "private_key" => KEY.to_pem, "token_uri" => "https://oauth2.googleapis.com/token" }.freeze

  setup { Rails.cache.delete(FcmClient::ACCESS_TOKEN_CACHE) }

  def http_response(klass, code, body)
    klass.new("1.1", code, "").tap do |response|
      response.instance_variable_set(:@body, body.to_json)
      response.instance_variable_set(:@read, true)
    end
  end

  def deliver_with(answer)
    sent = {}
    token_request = ->(uri, form) { sent[:token_uri] = uri.to_s; sent[:form] = form; http_response(Net::HTTPOK, "200", access_token: "ya29.test", expires_in: 3599) }
    client = FcmClient.new(CREDENTIALS)
    post = ->(uri, payload, headers) { sent[:uri] = uri.to_s; sent[:payload] = payload; sent[:headers] = headers; answer }
    result = Net::HTTP.stub(:post_form, token_request) do
      client.stub(:post_json, post) { client.deliver(token: "phone-token", title: "🔔 Reminders", body: "🧽 Kitchen fountain", url: "https://example.com/en/today") }
    end
    [ result, sent ]
  end

  test "sends a signed message for the reminders channel, with the Today link" do
    result, sent = deliver_with(http_response(Net::HTTPOK, "200", name: "projects/pet-tracker-test/messages/1"))
    assert_equal :sent, result
    assert_equal "https://fcm.googleapis.com/v1/projects/pet-tracker-test/messages:send", sent[:uri]
    assert_equal "Bearer ya29.test", sent[:headers]["Authorization"]
    assert_equal({ token: "phone-token", notification: { title: "🔔 Reminders", body: "🧽 Kitchen fountain" }, data: { url: "https://example.com/en/today" },
                   android: { priority: "high", notification: { channel_id: "reminders" } } }, sent[:payload][:message])

    assert_equal "urn:ietf:params:oauth:grant-type:jwt-bearer", sent[:form][:grant_type]
    header, claims, signature = sent[:form][:assertion].split(".")
    assert KEY.public_key.verify(OpenSSL::Digest.new("SHA256"), Base64.urlsafe_decode64(signature), "#{header}.#{claims}"), "signed with the service account's key"
    claims = JSON.parse(Base64.urlsafe_decode64(claims))
    assert_equal [ CREDENTIALS["client_email"], FcmClient::SCOPE, CREDENTIALS["token_uri"] ], claims.values_at("iss", "scope", "aud")
  end

  test "a token FCM no longer knows is gone; other errors are failures" do
    unregistered = { error: { code: 404, status: "NOT_FOUND", details: [ { "@type" => "type.googleapis.com/google.firebase.fcm.v1.FcmError", errorCode: "UNREGISTERED" } ] } }
    assert_equal :gone, deliver_with(http_response(Net::HTTPNotFound, "404", unregistered)).first
    invalid = { error: { code: 400, status: "INVALID_ARGUMENT", message: "The registration token is not a valid FCM registration token" } }
    assert_equal :gone, deliver_with(http_response(Net::HTTPBadRequest, "400", invalid)).first
    assert_equal :failed, deliver_with(http_response(Net::HTTPServiceUnavailable, "503", error: { status: "UNAVAILABLE" })).first
  end

  test "push is off without the service account" do
    with_env("FIREBASE_SERVICE_ACCOUNT_JSON" => nil) { assert_not FcmClient.configured? }
    with_env("FIREBASE_SERVICE_ACCOUNT_JSON" => "not json") { assert_not FcmClient.configured? }
    with_env("FIREBASE_SERVICE_ACCOUNT_JSON" => CREDENTIALS.to_json) { assert FcmClient.configured? }
  end

  private

  def with_env(values)
    previous = values.keys.to_h { |key| [ key, ENV[key] ] }
    values.each { |key, value| ENV[key] = value }
    yield
  ensure
    previous.each { |key, value| ENV[key] = value }
  end
end
