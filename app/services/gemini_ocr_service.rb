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
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = body.to_json

    response = http.request(request)

    if response.code == "200"
      result = JSON.parse(response.body)
      extract_json_from_response(result)
    elsif response.code == "429"
      if using_user_key?
        { error: "Your personal Gemini API quota has been reached. Please wait or upgrade your Google account." }
      else
        { error: "Our global AI quota has been reached for today. To use this feature immediately, please add your own free Gemini API key in your Profile settings." }
      end
    else
      { error: "API Error (#{response.code}): #{response.body[0..200]}" }
    end
  rescue => e
    { error: "Service Error: #{e.message}" }
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
...
    <<~PROMPT
      Act as a specialized veterinary lab result data extraction tool.
      Analyze the provided health checkup report image(s). If multiple images are provided, combine the data from all of them into a single consolidated report.
      Extract the numerical values for these keys:
      exam_date (YYYY-MM-DD), rbc, hct, hgb, mcv, mch, mchc, rdw, retic, retic_hgb, wbc, neu, lym, mono, eos, baso, plt, mpv, pct, glu, crea, bun, phos, tp, alb, glob, alt, alkp, na, k, cl, ca, chol, ggt, tbil, amyl, fpl2, lipa, osm_cal, fbnp, felv, fiv.
      Return ONLY a JSON object. If a value is missing across all images, use null.
    PROMPT
  end

  def extract_json_from_response(result)
    text_content = result.dig("candidates", 0, "content", "parts", 0, "text")
    return { error: "No text returned from Gemini" } if text_content.blank?

    # Try to find JSON in the text
    json_match = text_content.match(/\{.*\}/m)
    if json_match
      JSON.parse(json_match[0])
    else
      JSON.parse(text_content)
    end
  rescue => e
    { error: "Data extraction failed. Gemini said: #{text_content.to_s[0..100]}..." }
  end
end
