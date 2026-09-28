require "net/http"

module KibblePrices
  # The backup source: asks Gemini, with Google Search, where a kibble is sold in
  # Taiwan and for how much. Its prices come from Google's index, so they may be
  # out of date or wrong, and are always shown as unverified. Only used for a
  # kibble BigGo and PChome found nothing for, with the owner's own API key.
  module GeminiSearch
    SOURCE = "Gemini".freeze
    API_URL = GeminiOcrService::API_URL

    def self.call(query, api_key:)
      return [] if api_key.blank?

      key = "kibble_prices:gemini:#{Date.current.strftime('%Y-%m')}:#{Digest::SHA256.hexdigest(query)}"
      rows = Rails.cache.read(key)
      if rows.nil?
        rows = fetch(query, api_key)
        Rails.cache.write(key, rows, expires_in: 35.days) unless rows.nil?
      end
      Array(rows).map { |row| Listing.new(**row) }
    end

    # nil when the request failed, so a failure is not cached for the month.
    def self.fetch(query, api_key)
      uri = URI.parse(API_URL)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.open_timeout = 10
      http.read_timeout = 60 # a search-grounded answer takes a while

      # The key goes in a header, not the URL: URLs end up in proxy logs and error messages.
      request = Net::HTTP::Post.new(uri.request_uri, "Content-Type" => "application/json", "x-goog-api-key" => api_key)
      request.body = { contents: [ { parts: [ { text: prompt(query) } ] } ], tools: [ { google_search: {} } ] }.to_json

      response = http.request(request)
      unless response.code == "200"
        Rails.logger.warn("[KibblePrices] Gemini answered #{response.code} for #{query.inspect}")
        return
      end

      parse(JSON.parse(response.body).dig("candidates", 0, "content", "parts")&.filter_map { |part| part["text"] }&.join)
    rescue JSON::ParserError, Net::OpenTimeout, Net::ReadTimeout, SocketError, SystemCallError, OpenSSL::SSL::SSLError => e
      Rails.logger.warn("[KibblePrices] Gemini request failed for #{query.inspect}: #{e.class}: #{e.message}")
      nil
    end

    def self.prompt(query)
      <<~PROMPT
        Search Google for shops in Taiwan that currently sell this pet food: #{query}
        Give up to 8 offers, each for one bag size of exactly this product.
        Answer with a JSON array only, no other text:
        [{"store": "shop name", "url": "https://product page", "price_twd": 1234, "product_title": "the product name as the shop lists it, including the bag size"}]
        Leave out any offer whose price or product page you cannot find. Do not guess.
      PROMPT
    end

    # The JSON array in Gemini's answer, as Listing hashes. An answer is often
    # wrapped in ```json fences or a sentence, so the array is cut out first.
    def self.parse(text)
      array = text.to_s[/\[.*\]/m]
      return [] if array.nil?

      Array(JSON.parse(array)).filter_map do |offer|
        next unless offer.is_a?(Hash)

        url = product_url(offer["url"])
        title = offer["product_title"].to_s.squish
        price = Integer(offer["price_twd"].to_s.delete(",").presence || "x", exception: false)
        next if url.nil? || title.blank? || price.nil?

        { source: SOURCE, store: offer["store"].to_s.squish.presence, title: title, variant: nil, price_twd: price, url: url }
      end
    rescue JSON::ParserError
      []
    end

    def self.product_url(url)
      uri = URI.parse(url.to_s)
      uri.is_a?(URI::HTTP) && uri.host.present? ? uri.to_s : nil
    rescue URI::InvalidURIError
      nil
    end
  end
end
