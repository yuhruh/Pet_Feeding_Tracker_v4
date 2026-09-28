require "cgi"

module KibblePrices
  # Reads the first page of a BigGo search: every listing's title, price, shop and
  # link. BigGo lists many shops at once, including Shopee, which cannot be read directly.
  module BigGoSearch
    SOURCE = "BigGo".freeze
    # BigGo's class names end in a build hash ("..._product-price__ETFme") that changes
    # when it redeploys, so each selector matches the stable start only.
    ITEM = '[class*="ProductItemListPC_product-item-list-PC"]'.freeze
    TITLE_LINK = '[class*="ProductItemListPC_product-title"] a'.freeze
    PRICE = '[class*="ProductItemListPC_product-price"]'.freeze
    VARIANT = '[class*="MultipleSpec_spec"]'.freeze
    VARIANT_PRICE = '[class*="MultipleSpec_price"]'.freeze
    STORE = '[class*="StoreName_store"]'.freeze
    # Shown when a search genuinely has no results, as opposed to a changed layout.
    NO_RESULTS = "搜尋不到符合".freeze

    # Listings for the query, fetched at most once a month however many pets eat it.
    def self.call(query)
      key = "kibble_prices:biggo:#{Date.current.strftime('%Y-%m')}:#{Digest::SHA256.hexdigest(query)}"
      rows = Rails.cache.read(key)
      if rows.nil?
        rows = fetch(query)
        Rails.cache.write(key, rows, expires_in: 35.days) unless rows.nil?
      end
      Array(rows).map { |row| Listing.new(**row) }
    end

    # Hashes rather than Listings, so the cache holds plain data. nil when the
    # request failed, so a failure is not cached for the month.
    def self.fetch(query)
      code, body = PoliteHttp.get("https://biggo.com.tw/s/#{ERB::Util.url_encode(query)}/")
      unless code == 200
        Rails.logger.warn("[KibblePrices] BigGo answered #{code} for #{query.inspect}")
        return
      end

      rows = parse(body)
      SourceAlert.call(SOURCE, query, "no listings and no 'no results' notice") if rows.empty? && !body.include?(NO_RESULTS)
      rows
    rescue PoliteHttp::Error, Net::OpenTimeout, Net::ReadTimeout, SocketError, SystemCallError, OpenSSL::SSL::SSLError => e
      Rails.logger.warn("[KibblePrices] BigGo request failed for #{query.inspect}: #{e.class}: #{e.message}")
      nil
    end

    def self.parse(html)
      Nokogiri::HTML(html).css(ITEM).filter_map do |item|
        link = item.at_css(TITLE_LINK)
        title = link&.[]("title").presence || link&.text
        variant = item.at_css(VARIANT)&.text&.squish.presence
        # A listing with several variants shows a range; the variant's own price is the one to use.
        price = variant ? price_of(item.at_css(VARIANT_PRICE)&.text) : price_of(item.at_css(PRICE)&.text)
        next if title.blank? || price.nil?

        { source: SOURCE, store: item.at_css(STORE)&.text&.squish, title: title.squish, variant: variant,
          price_twd: price, url: store_url(link["href"]) }
      end
    end

    # "$1,449" => 1449. A range ("$1,800 ~ $3,450") has no single price, so nil.
    def self.price_of(text)
      text = text.to_s
      return if text.include?("~")

      digits = text.delete("^0-9")
      digits.empty? ? nil : digits.to_i
    end

    # BigGo's link is a redirect (/r/?...&purl=<shop URL>) that robots.txt asks not to
    # be fetched; the shop's own URL is inside it, so link there instead.
    def self.store_url(href)
      uri = URI.join("https://biggo.com.tw", href.to_s)
      purl = CGI.parse(uri.query.to_s)["purl"]&.first
      # Shop URLs may hold Chinese characters, which URI only accepts escaped.
      target = purl && URI.parse(purl.gsub(/[^\x00-\x7F]/) { |char| CGI.escape(char) })
      target.is_a?(URI::HTTP) ? target.to_s : uri.to_s
    rescue URI::InvalidURIError
      nil
    end
  end
end
