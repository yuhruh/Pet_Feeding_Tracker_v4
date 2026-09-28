module KibblePrices
  # PChome's own search API. It is undocumented, so any failure just means no
  # PChome listings; BigGo usually lists PChome too.
  module PchomeSearch
    SOURCE = "PChome".freeze
    STORE = "PChome 24h購物".freeze

    def self.call(query)
      key = "kibble_prices:pchome:#{Date.current.strftime('%Y-%m')}:#{Digest::SHA256.hexdigest(query)}"
      rows = Rails.cache.read(key)
      if rows.nil?
        rows = fetch(query)
        Rails.cache.write(key, rows, expires_in: 35.days) unless rows.nil?
      end
      Array(rows).map { |row| Listing.new(**row) }
    end

    def self.fetch(query)
      code, body = PoliteHttp.get("https://ecshweb.pchome.com.tw/search/v4.3/all/results?q=#{ERB::Util.url_encode(query)}&page=1")
      unless code == 200
        Rails.logger.warn("[KibblePrices] PChome answered #{code} for #{query.inspect}")
        return
      end

      data = JSON.parse(body)
      unless data.is_a?(Hash) && data.key?("Prods")
        SourceAlert.call(SOURCE, query, "response has no Prods list")
        return []
      end

      Array(data["Prods"]).filter_map do |prod|
        next if prod["Name"].blank? || prod["Id"].blank? || !prod["Price"].is_a?(Integer)

        { source: SOURCE, store: STORE, title: prod["Name"].squish, variant: nil, price_twd: prod["Price"],
          url: "https://24h.pchome.com.tw/prod/#{ERB::Util.url_encode(prod['Id'])}" }
      end
    rescue JSON::ParserError
      SourceAlert.call(SOURCE, query, "response is not JSON")
      []
    rescue PoliteHttp::Error, Net::OpenTimeout, Net::ReadTimeout, SocketError, SystemCallError, OpenSSL::SSL::SSLError => e
      Rails.logger.warn("[KibblePrices] PChome request failed for #{query.inspect}: #{e.class}: #{e.message}")
      nil
    end
  end
end
