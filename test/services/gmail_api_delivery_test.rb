require "test_helper"
require "minitest/mock"

class GmailApiDeliveryTest < ActiveSupport::TestCase
  CREDENTIALS = { client_id: "test-client-id", client_secret: "test-client-secret", refresh_token: "test-refresh-token" }.freeze

  # Records every request and replies with the queued responses, so no mail is sent.
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

  def token_response(token = "access-token-123", expires_in = 3599)
    FakeResponse.new("200", { access_token: token, expires_in: expires_in, token_type: "Bearer" }.to_json)
  end

  def sent_response
    FakeResponse.new("200", { id: "18f0", labelIds: [ "SENT" ] }.to_json)
  end

  def deliver(mail, responses:, settings: CREDENTIALS)
    http = FakeHTTP.new(responses)
    Net::HTTP.stub(:new, http) { GmailApiDelivery.new(settings).deliver!(mail) }
    http
  end

  def mail
    Mail.new(from: "ajicaretracker@gmail.com", to: "owner@example.com", subject: "Reset your password", body: "https://example.com/passwords/abc/edit")
  end

  test "is registered as an ActionMailer delivery method" do
    assert_equal GmailApiDelivery, ActionMailer::Base.delivery_methods[:gmail_api]
  end

  test "refreshes an access token, then sends the message over HTTPS" do
    http = deliver(mail, responses: [ token_response, sent_response ])

    token_request, send_request = http.requests
    assert_equal "/token", token_request.path
    token_params = URI.decode_www_form(token_request.body).to_h
    assert_equal "refresh_token", token_params["grant_type"]
    assert_equal CREDENTIALS[:refresh_token], token_params["refresh_token"]

    assert_equal "/gmail/v1/users/me/messages/send", send_request.path
    assert_equal "Bearer access-token-123", send_request["Authorization"]
    raw = JSON.parse(send_request.body)["raw"]
    message = Base64.urlsafe_decode64(raw)
    assert_includes message, "Subject: Reset your password"
    assert_includes message, "owner@example.com"
  end

  test "keeps credentials out of the URLs" do
    http = deliver(mail, responses: [ token_response, sent_response ])
    http.requests.each do |request|
      assert_not_includes request.path, "client_secret"
      assert_not_includes request.path, CREDENTIALS[:refresh_token]
    end
  end

  test "raises with Google's message, without leaking credentials" do
    error = assert_raises GmailApiDelivery::DeliveryError do
      deliver(mail, responses: [ token_response, FakeResponse.new("403", { error: { message: "Request had insufficient authentication scopes." } }.to_json) ])
    end
    assert_includes error.message, "insufficient authentication scopes"
    assert_includes error.message, "(403)"
    assert_not_includes error.message, CREDENTIALS[:refresh_token]
    assert_not_includes error.message, CREDENTIALS[:client_secret]
  end

  test "retries once with a fresh token when the token has expired" do
    expired = FakeResponse.new("401", { error: { message: "Invalid Credentials" } }.to_json)
    http = deliver(mail, responses: [ token_response, expired, token_response("access-token-456"), sent_response ])

    assert_equal 4, http.requests.size
    assert_equal "Bearer access-token-456", http.requests.last["Authorization"]
  end

  test "says so when the credentials are missing, without contacting Google" do
    GmailApiDelivery.stub(:credentials, { client_id: nil, client_secret: nil, refresh_token: nil }) do
      Net::HTTP.stub(:new, ->(*) { flunk "Google must not be contacted" }) do
        error = assert_raises(GmailApiDelivery::DeliveryError) { GmailApiDelivery.new({}).deliver!(mail) }
        assert_includes error.message, "GMAIL_REFRESH_TOKEN"
      end
    end
  end

  test "a real password reset email goes out this way" do
    user = users(:one)
    http = FakeHTTP.new([ token_response, sent_response ])

    with_delivery_method(:gmail_api) do
      ActionMailer::Base.gmail_api_settings = CREDENTIALS
      Net::HTTP.stub(:new, http) { PasswordsMailer.reset(user).deliver_now }
    end

    # Parse it back: headers are encoded when they hold non-ASCII characters.
    sent = Mail.read_from_string(Base64.urlsafe_decode64(JSON.parse(http.requests.last.body)["raw"]))
    assert_equal [ user.email_address ], sent.to
    assert_equal I18n.t("passwords_mailer.reset.subject"), sent.subject
    assert_match %r{/passwords/[^/\s]+/edit}, sent.text_part.body.decoded
  end

  private
    def with_delivery_method(method)
      previous = ActionMailer::Base.delivery_method
      ActionMailer::Base.delivery_method = method
      yield
    ensure
      ActionMailer::Base.delivery_method = previous
    end
end
