require "net/http"
require "uri"
require "json"
require "base64"

# ActionMailer delivery method that sends through the Gmail API over HTTPS (port 443).
#
# Two reasons to prefer it over SMTP or a third-party sender for this app:
#   * Many hosts block outbound SMTP ports on cheap plans (Railway below Pro, Render free).
#   * Mail sent "from gmail.com" through a third party fails Gmail's authenticity
#     checks and lands in spam. Sent through Gmail itself, it passes.
#
# Authenticates with an OAuth refresh token for the sending account; no password is
# stored. Run `bin/rails gmail:refresh_token` once to obtain one.
class GmailApiDelivery
  TOKEN_URL = "https://oauth2.googleapis.com/token"
  SEND_URL = "https://gmail.googleapis.com/gmail/v1/users/me/messages/send"
  OPEN_TIMEOUT = 10
  READ_TIMEOUT = 30
  ACCESS_TOKEN_CACHE_KEY = "gmail_api/access_token"

  class DeliveryError < StandardError; end

  attr_accessor :settings

  def self.credentials
    {
      client_id: ENV["GMAIL_CLIENT_ID"] || Rails.application.credentials.dig(:gmail_api, :client_id),
      client_secret: ENV["GMAIL_CLIENT_SECRET"] || Rails.application.credentials.dig(:gmail_api, :client_secret),
      refresh_token: ENV["GMAIL_REFRESH_TOKEN"] || Rails.application.credentials.dig(:gmail_api, :refresh_token)
    }
  end

  # ActionMailer passes gmail_api_settings; anything missing falls back to the credentials.
  def initialize(settings = {})
    self.settings = self.class.credentials.merge(settings.to_h.symbolize_keys.compact_blank)
  end

  def deliver!(mail)
    unless %i[client_id client_secret refresh_token].all? { |key| settings[key].present? }
      raise DeliveryError, "Gmail API credentials are missing (GMAIL_CLIENT_ID, GMAIL_CLIENT_SECRET, GMAIL_REFRESH_TOKEN)"
    end

    send_message(mail, access_token)
  rescue DeliveryError => error
    # A cached access token can expire early (e.g. the token was revoked); try once with a fresh one.
    raise error unless error.message.include?("(401)") && !@retried

    @retried = true
    Rails.cache.delete(ACCESS_TOKEN_CACHE_KEY)
    send_message(mail, access_token)
  end

  private

  def access_token
    cached = Rails.cache.read(ACCESS_TOKEN_CACHE_KEY)
    return cached if cached.present?

    body = post(URI(TOKEN_URL), step: "token request", form: {
      client_id: settings[:client_id],
      client_secret: settings[:client_secret],
      refresh_token: settings[:refresh_token],
      grant_type: "refresh_token"
    })
    token = body["access_token"]
    raise DeliveryError, "Gmail API token request returned no access token" if token.blank?

    # Tokens last about an hour; keep a minute's headroom.
    Rails.cache.write(ACCESS_TOKEN_CACHE_KEY, token, expires_in: [ body["expires_in"].to_i - 60, 60 ].max.seconds)
    token
  end

  def send_message(mail, token)
    post(URI(SEND_URL), step: "send request",
         json: { raw: Base64.urlsafe_encode64(mail.to_s) },
         headers: { "Authorization" => "Bearer #{token}" })
  end

  def post(uri, step:, form: nil, json: nil, headers: {})
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = OPEN_TIMEOUT
    http.read_timeout = READ_TIMEOUT

    request = Net::HTTP::Post.new(uri.request_uri, headers)
    if form
      request.set_form_data(form)
    else
      request["Content-Type"] = "application/json"
      request.body = json.to_json
    end

    parse(http.request(request), step)
  end

  # Returns the parsed body, or raises with Google's message only: never our credentials.
  def parse(response, step)
    body = JSON.parse(response.body.to_s) rescue {}
    return body if response.code.to_i.between?(200, 299)

    message = body.dig("error", "message") || body["error_description"] || body["error"] || "no details"
    raise DeliveryError, "Gmail API #{step} failed (#{response.code}): #{message}"
  end
end
