require "net/http"
require "uri"
require "json"
require "base64"

class GeminiOcrService
  # Using v1beta and gemini-flash-latest as it is the most stable alias in your model list
  API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent"

  # Upload limits. Images are sent inline, and inline data counts toward Gemini's
  # 20 MB request limit after base64 encoding (about 4/3 of the file size).
  MAX_FILES = 5
  MAX_FILE_SIZE = 10.megabytes
  MAX_TOTAL_SIZE = 14.megabytes
  # Detected from each file's contents, never from its name or the browser's content type.
  ALLOWED_TYPES = %w[image/png image/jpeg image/webp image/heic image/heif].freeze

  # Returns a user-facing message if these files must not be sent to Gemini, otherwise nil.
  def self.upload_error(file_paths)
    paths = Array(file_paths)
    return I18n.t("services.gemini_ocr.no_files") if paths.empty?
    return I18n.t("services.gemini_ocr.too_many_files", max: MAX_FILES) if paths.size > MAX_FILES

    sizes = paths.map { |path| File.size(path) }
    return I18n.t("services.gemini_ocr.file_too_large", max: human_size(MAX_FILE_SIZE)) if sizes.any? { |size| size > MAX_FILE_SIZE }
    return I18n.t("services.gemini_ocr.total_too_large", max: human_size(MAX_TOTAL_SIZE)) if sizes.sum > MAX_TOTAL_SIZE
    return I18n.t("services.gemini_ocr.unsupported_type") unless paths.all? { |path| ALLOWED_TYPES.include?(mime_type_of(path)) }

    nil
  end

  def self.mime_type_of(path)
    Marcel::MimeType.for(Pathname.new(path))
  end

  # One formatting for the hint, the browser messages and the server messages:
  # "10 MB" in every locale (zh-TW would otherwise show "10.0 MB").
  def self.human_size(bytes)
    ActiveSupport::NumberHelper.number_to_human_size(bytes, strip_insignificant_zeros: true)
  end

  def initialize(file_paths, user = nil)
    @file_paths = Array(file_paths) # Ensure it's an array
    @user = user
    @api_key = user_api_key
  end

  def call
    return { error: "Please add your personal Gemini API Key in User Profile" } if @api_key.blank?
    if (upload_error = self.class.upload_error(@file_paths))
      return { error: upload_error }
    end

    uri = URI.parse(API_URL)
    # The key goes in a header, not the URL: URLs end up in proxy logs and error messages.
    header = { "Content-Type" => "application/json", "x-goog-api-key" => @api_key }

    # Construct the parts array starting with the prompt
    parts = [ { text: prompt_text } ]

    # Add each image as a separate part
    @file_paths.each do |path|
      parts << {
        inline_data: {
          mime_type: self.class.mime_type_of(path),
          data: Base64.strict_encode64(File.binread(path))
        }
      }
    end

    body = { contents: [ { parts: parts } ] }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = 10
    http.write_timeout = 30
    http.read_timeout = 90 # reading several report images can take a while
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = body.to_json

    response = http.request(request)

    if response.code == "200"
      result = JSON.parse(response.body)
      extract_json_from_response(result)
    elsif response.code == "429"
      if using_user_key?
        { error: I18n.t("services.gemini_ocr.user_quota_reached") }
      else
        { error: "Please add your personal Gemini API Key" }
      end
    else
      { error: I18n.t("services.gemini_ocr.api_error", code: response.code) }
    end
  rescue => e
    { error: I18n.t("services.gemini_ocr.service_error", message: e.message) }
  end

  private

  def user_api_key
    @user&.gemini_api_key.presence
  end

  # def global_api_key
  #   Rails.application.credentials.gemini_api_key
  # end

  def using_user_key?
    user_api_key.present?
  end

  def prompt_text
  I18n.with_locale(:en) do
    I18n.t("services.gemini_ocr.prompt")
  end
  end
  def extract_json_from_response(result)
    text_content = result.dig("candidates", 0, "content", "parts", 0, "text")
    return { error: I18n.t("services.gemini_ocr.no_text_returned") } if text_content.blank?

    # Try to find JSON in the text
    json_match = text_content.match(/\{.*\}/m)
    if json_match
      JSON.parse(json_match[0])
    else
      JSON.parse(text_content)
    end
  rescue => e
    { error: I18n.t("services.gemini_ocr.extraction_failed", message: e.message) }
  end
end
