module KibblePrices
  # Tells the admin a price source stopped returning what the parser expects,
  # at most once a day per source, so a changed page layout is noticed.
  module SourceAlert
    def self.call(source, query, detail)
      Rails.logger.warn("[KibblePrices] #{source} returned nothing usable for #{query.inspect}: #{detail}")
      first_today = Rails.cache.write("kibble_prices:alert:#{source}:#{Date.current}", true, unless_exist: true, expires_in: 1.day)
      DiagnosticsMailer.price_source_alert(source: source, query: query, detail: detail).deliver_later if first_today
    end
  end
end
