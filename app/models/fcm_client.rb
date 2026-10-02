require "net/http"

# Sends Android app notifications through Firebase Cloud Messaging's HTTP v1
# API (checkpoint I). The Firebase service account's JSON key is in the
# FIREBASE_SERVICE_ACCOUNT_JSON environment variable, never in git; without it
# push is off. Its private key signs a short-lived Google access token.
class FcmClient
  SCOPE = "https://www.googleapis.com/auth/firebase.messaging".freeze
  CHANNEL = "reminders".freeze # the app's notification channel
  ACCESS_TOKEN_CACHE = "fcm_access_token".freeze
  TIMEOUT = 10 # seconds

  def self.credentials
    json = ENV["FIREBASE_SERVICE_ACCOUNT_JSON"].presence or return
    JSON.parse(json).slice("project_id", "client_email", "private_key", "token_uri").presence
  rescue JSON::ParserError
    nil
  end

  def self.configured? = credentials.present?

  def initialize(credentials = self.class.credentials)
    @credentials = credentials or raise ArgumentError, "FIREBASE_SERVICE_ACCOUNT_JSON is not set"
  end

  # :sent, :gone (the token is no longer valid; forget it) or :failed.
  def deliver(token:, title:, body:, url:)
    response = post_json(URI("https://fcm.googleapis.com/v1/projects/#{@credentials['project_id']}/messages:send"),
                         message(token, title, body, url), "Authorization" => "Bearer #{access_token}")
    return :sent if response.is_a?(Net::HTTPSuccess)

    gone?(response) ? :gone : :failed
  end

  private

  def message(token, title, body, url)
    { message: { token: token, notification: { title: title, body: body }, data: { url: url },
                 android: { priority: "high", notification: { channel_id: CHANNEL } } } }
  end

  # UNREGISTERED (404) or an invalid registration token (400): the app was
  # uninstalled or the token replaced.
  def gone?(response)
    details = JSON.parse(response.body.to_s) rescue {}
    status = details.dig("error", "status")
    codes = Array(details.dig("error", "details")).filter_map { |detail| detail["errorCode"] }
    response.code == "404" || codes.include?("UNREGISTERED") ||
      (status == "INVALID_ARGUMENT" && details.dig("error", "message").to_s.match?(/registration token/i))
  end

  def access_token
    Rails.cache.fetch(ACCESS_TOKEN_CACHE, expires_in: 50.minutes) do
      response = Net::HTTP.post_form(URI(token_uri), grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer", assertion: signed_assertion)
      raise "Firebase access token: #{response.code}" unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body).fetch("access_token")
    end
  end

  def token_uri = @credentials["token_uri"].presence || "https://oauth2.googleapis.com/token"

  # A JWT signed with the service account's key (RS256).
  def signed_assertion
    now = Time.current.to_i
    header = { alg: "RS256", typ: "JWT" }
    claims = { iss: @credentials["client_email"], scope: SCOPE, aud: token_uri, iat: now, exp: now + 3600 }
    input = [ header, claims ].map { |part| Base64.urlsafe_encode64(part.to_json, padding: false) }.join(".")
    signature = OpenSSL::PKey::RSA.new(@credentials["private_key"]).sign(OpenSSL::Digest.new("SHA256"), input)
    "#{input}.#{Base64.urlsafe_encode64(signature, padding: false)}"
  end

  def post_json(uri, payload, headers)
    request = Net::HTTP::Post.new(uri, headers.merge("Content-Type" => "application/json"))
    request.body = payload.to_json
    Net::HTTP.start(uri.host, uri.port, use_ssl: true, open_timeout: TIMEOUT, read_timeout: TIMEOUT) { |http| http.request(request) }
  end
end
