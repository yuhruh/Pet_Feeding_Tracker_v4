require "net/http"
require "uri"
require "json"
require "securerandom"

# Talks to a user's Google Drive for their daily backup, over HTTPS like GmailApiDelivery.
#
# Asks only for drive.file: the app sees the files and folders it created, never the
# rest of the user's Drive. Uses the Google sign-in OAuth client (GOOGLE_CLIENT_ID).
class GoogleDriveClient
  AUTH_URL = "https://accounts.google.com/o/oauth2/v2/auth"
  TOKEN_URL = "https://oauth2.googleapis.com/token"
  REVOKE_URL = "https://oauth2.googleapis.com/revoke"
  ABOUT_URL = "https://www.googleapis.com/drive/v3/about"
  FILES_URL = "https://www.googleapis.com/drive/v3/files"
  UPLOAD_URL = "https://www.googleapis.com/upload/drive/v3/files"
  SCOPE = "https://www.googleapis.com/auth/drive.file"
  FOLDER_TYPE = "application/vnd.google-apps.folder"
  OPEN_TIMEOUT = 10
  READ_TIMEOUT = 60

  class Error < StandardError
    attr_reader :status

    def initialize(message, status: nil)
      super(message)
      @status = status
    end
  end
  # The user removed the app's access in their Google account: they have to connect again.
  class Unauthorized < Error; end

  def self.credentials
    { client_id: GOOGLE_ID, client_secret: GOOGLE_SECRET }
  end

  # prompt=consent makes Google return a refresh token on every connect, not only the first.
  def self.authorize_url(redirect_uri:, state:)
    query = { client_id: credentials[:client_id], redirect_uri: redirect_uri, response_type: "code",
              scope: SCOPE, access_type: "offline", prompt: "consent", state: state }
    "#{AUTH_URL}?#{URI.encode_www_form(query)}"
  end

  # Trades the code Google sent back for a refresh token. Google lets the user untick
  # Drive on the consent screen, so a token without it is refused.
  def self.exchange_code(code, redirect_uri:)
    body = new(nil).send(:call, :post, TOKEN_URL, step: "code exchange",
                         form: credentials.merge(code: code, redirect_uri: redirect_uri, grant_type: "authorization_code"))
    raise Error, "Google returned no refresh token" if body["refresh_token"].blank?
    raise Error, "drive_permission_missing" unless body["scope"].to_s.split.include?(SCOPE)

    body["refresh_token"]
  end

  # Best effort: the connection is forgotten here even if Google can't be reached.
  def self.revoke(refresh_token)
    new(nil).send(:call, :post, REVOKE_URL, step: "revoke", form: { token: refresh_token })
    true
  rescue Error
    false
  end

  def initialize(refresh_token)
    @refresh_token = refresh_token
  end

  def email
    authorized(:get, "#{ABOUT_URL}?fields=user(emailAddress)", step: "account lookup").dig("user", "emailAddress")
  end

  # False once the folder is deleted or in the trash, so the next backup makes a new one.
  def folder?(id)
    !authorized(:get, "#{FILES_URL}/#{id}?fields=trashed", step: "folder lookup")["trashed"]
  rescue Error => error
    raise unless error.status == 404

    false
  end

  def create_folder(name)
    authorized(:post, "#{FILES_URL}?fields=id", step: "folder create", json: { name: name, mimeType: FOLDER_TYPE })["id"]
  end

  # Replaces the file's contents (Drive keeps the earlier versions), or creates it when
  # there's none yet or it was deleted. A file in the trash comes back out. Returns its id.
  def upload_csv(name:, csv:, folder_id:, file_id: nil)
    if file_id.present?
      begin
        return multipart(:patch, "#{UPLOAD_URL}/#{file_id}?uploadType=multipart&fields=id", { name: name, trashed: false }, csv)
      rescue Error => error
        raise unless error.status == 404
      end
    end

    multipart(:post, "#{UPLOAD_URL}?uploadType=multipart&fields=id", { name: name, parents: [ folder_id ], mimeType: "text/csv" }, csv)
  end

  private

  def multipart(method, url, metadata, csv)
    boundary = "pet_tracker_#{SecureRandom.hex(12)}"
    body = [
      "--#{boundary}", "Content-Type: application/json; charset=UTF-8", "", metadata.to_json,
      "--#{boundary}", "Content-Type: text/csv; charset=UTF-8", "", csv,
      "--#{boundary}--", ""
    ].join("\r\n")
    authorized(method, url, step: "upload", body: body, content_type: "multipart/related; boundary=#{boundary}")["id"]
  end

  def authorized(method, url, step:, **options)
    call(method, url, step: step, headers: { "Authorization" => "Bearer #{access_token}" }, **options)
  end

  # One access token per client: a backup run is a few requests well inside its hour.
  def access_token
    @access_token ||= call(:post, TOKEN_URL, step: "token request", form: self.class.credentials.merge(
      refresh_token: @refresh_token, grant_type: "refresh_token"
    ))["access_token"]
  end

  def call(method, url, step:, form: nil, json: nil, body: nil, content_type: nil, headers: {})
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = OPEN_TIMEOUT
    http.read_timeout = READ_TIMEOUT

    request = Net::HTTP.const_get(method.to_s.capitalize).new(uri.request_uri, headers)
    if form
      request.set_form_data(form)
    elsif json
      request["Content-Type"] = "application/json"
      request.body = json.to_json
    elsif body
      request["Content-Type"] = content_type
      request.body = body
    end

    parse(http.request(request), step)
  rescue SocketError, SystemCallError, Timeout::Error, IOError, OpenSSL::SSL::SSLError => error
    raise Error, "Google Drive #{step} could not reach Google (#{error.class})"
  end

  # Returns the parsed body, or raises with Google's message only: never a token.
  def parse(response, step)
    body = JSON.parse(response.body.to_s) rescue {}
    status = response.code.to_i
    return body if status.between?(200, 299)

    # invalid_grant: the refresh token was revoked or expired.
    if body["error"] == "invalid_grant" || status == 401
      raise Unauthorized.new("Google Drive #{step} was refused (#{status})", status: status)
    end

    message = body.dig("error", "message") || body["error_description"] || body["error"] || "no details"
    raise Error.new("Google Drive #{step} failed (#{status}): #{message}", status: status)
  end
end
