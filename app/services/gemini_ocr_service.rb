require "net/http"
require "uri"
require "json"
require "base64"

class GeminiOcrService
  # Using v1beta and gemini-flash-latest as it is the most stable alias in your model list
  API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent"

  def initialize(file_paths, user = nil)
    @file_paths = Array(file_paths) # Ensure it's an array
    @user = user
    @api_key = user_api_key || global_api_key
  end

  def call
    return { error: "API Key missing" } if @api_key.blank?
    return { error: "No files provided" } if @file_paths.empty?

    uri = URI.parse("#{API_URL}?key=#{@api_key}")
    header = { "Content-Type" => "application/json" }

    # Construct the parts array starting with the prompt
    parts = [ { text: prompt_text } ]

    # Add each image as a separate part
    @file_paths.each do |path|
      mime_type = path.downcase.end_with?(".png") ? "image/png" : "image/jpeg"
      parts << {
        inline_data: {
          mime_type: mime_type,
          data: Base64.strict_encode64(File.read(path))
        }
      }
    end

    body = { contents: [ { parts: parts } ] }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.read_timeout = 120 # Increase to 2 minutes
    http.write_timeout = 120
    http.open_timeout = 120
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
        { error: I18n.t("services.gemini_ocr.global_quota_reached") }
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

  def global_api_key
    Rails.application.credentials.gemini_api_key
  end

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
