module KibblePrices
  # Finds current Taiwan prices for a pet's favorite kibbles and ranks each
  # kibble's listings by NT$ per kg, cheapest first.
  class Lookup
    PRICE_RANGE = 50..20_000
    MAX_PRICES = 8
    SOURCES = [ BigGoSearch, PchomeSearch ].freeze
    # An unverified (Gemini) price this far from the reference NT$/kg is set aside as suspicious.
    SUSPICIOUS_DEVIATION = 0.4
    # Gemini's own prices are a reference only when there are enough of them to outvote one outlier.
    MIN_GEMINI_REFERENCE = 3

    def initialize(pet, **favorite_options)
      @pet = pet
      @favorite_options = favorite_options
    end

    # One entry per favorite kibble: { kibble:, queries:, prices:, rejected:, gemini: }.
    # rejected counts the listings each rule left out, for reviewing the matching.
    # gemini is nil when BigGo or PChome found prices, :used when Gemini was asked,
    # and :no_key when it would have been but the owner has no Gemini API key.
    def call
      kibbles = @pet.favorite_kibbles(**@favorite_options)
      species = self.class.species_of(kibbles)
      brand_groups = BrandNames.for_user(@pet.user)
      kibbles.map { |kibble| prices_for(kibble, species, brand_groups) }
    end

    # :cat or :dog when the pet's kibble names say so, otherwise nil (no species filter).
    def self.species_of(kibbles)
      text = kibbles.map { |k| "#{Query.brand(k)} #{Query.description(k)}" }.join(" ")
      cat, dog = text.scan(Matcher::CAT).size, text.scan(Matcher::DOG).size
      return :cat if cat > dog
      :dog if dog > cat
    end

    private

    def prices_for(kibble, species, brand_groups)
      brand = kibble[:dry_food]&.brand.presence || kibble[:brand]
      matcher = Matcher.new(kibble, species: species, brand_names: BrandNames.for_brand(brand, brand_groups))
      rejected = Hash.new(0)
      queries = []
      rows = []

      # The exact name first; the brand-wide search only when that finds nothing.
      Query.for(kibble, species: species).each do |query|
        queries << query
        SOURCES.flat_map { |source| source.call(query) }.each do |listing|
          reason = matcher.rejection(title: listing.title, variant: listing.variant)
          row = price_row(listing) unless reason
          reason ||= if row.nil? then :bag_size
          elsif !PRICE_RANGE.cover?(row[:price_twd]) then :price
          end
          reason ? rejected[reason] += 1 : rows << row
        end
        break if rows.any?
      end

      gemini = nil
      if rows.empty?
        gemini = @pet.user.gemini_api_key.present? ? :used : :no_key
        rows = gemini_rows(kibble, queries.first, matcher, rejected) if gemini == :used
      end

      { kibble: kibble, queries: queries, prices: rank(rows), rejected: rejected, gemini: gemini }
    end

    # Gemini's offers pass the same rules as listed ones, and one far from the
    # reference price is set aside as suspicious rather than ranked.
    def gemini_rows(kibble, query, matcher, rejected)
      rows = GeminiSearch.call(query, api_key: @pet.user.gemini_api_key).filter_map do |listing|
        reason = matcher.rejection(title: listing.title, variant: listing.variant)
        row = price_row(listing) unless reason
        reason ||= if row.nil? then :bag_size
        elsif !PRICE_RANGE.cover?(row[:price_twd]) then :price
        end
        reason ? (rejected[reason] += 1; nil) : row
      end

      reference = reference_price_per_kg(kibble, rows)
      return rows if reference.nil?

      rows.map do |row|
        deviation = row[:price_per_kg] / reference - 1
        next row if deviation.abs <= SUSPICIOUS_DEVIATION

        row.merge(suspicious: true, suspicious_reason: format("%+d%% from NT$%.0f/kg", (deviation * 100).round, reference))
      end
    end

    # What a fair NT$/kg looks like for this kibble: the median listed (BigGo or
    # PChome) price from the pet's latest earlier check that found some, or else
    # the median of Gemini's own offers when there are enough of them.
    def reference_price_per_kg(kibble, gemini_rows)
      earlier = KibblePrice.joins(:kibble_price_check)
                           .where(kibble_price_checks: { pet_id: @pet.id, status: "done" })
                           .where(kibble_price_checks: { checked_on: ...Date.current })
                           .where(brand: kibble[:brand], description: kibble[:description], suspicious: false)
                           .where.not(source: "Gemini")
      latest_date = earlier.maximum("kibble_price_checks.checked_on")
      listed = latest_date ? earlier.where(kibble_price_checks: { checked_on: latest_date }).pluck(:price_per_kg) : []

      prices = listed.presence || (gemini_rows.map { |row| row[:price_per_kg] } if gemini_rows.size >= MIN_GEMINI_REFERENCE)
      median(prices.map(&:to_f)) if prices.present?
    end

    def median(values)
      sorted = values.sort
      (sorted[(sorted.size - 1) / 2] + sorted[sorted.size / 2]) / 2.0
    end

    def price_row(listing)
      # The variant's size when it names one, since the price is for that variant.
      size = BagSize.parse(listing.variant) || (BagSize.parse(listing.title) unless listing.variant.to_s.match?(BagSize::SIZE))
      return if size.nil?

      listing.to_h.merge(bag_size_label: size[:label], bag_size_kg: size[:kg],
                         price_per_kg: (listing.price_twd / size[:kg]).round(1))
    end

    # The cheapest listing per shop and bag size, and each shop page once;
    # suspicious prices after all the others.
    def rank(rows)
      rows.sort_by { |row| [ row[:suspicious] ? 1 : 0, row[:price_per_kg] ] }
          .uniq { |row| [ row[:store], row[:bag_size_kg] ] }
          .uniq { |row| row[:url] }
          .first(MAX_PRICES)
    end
  end
end
