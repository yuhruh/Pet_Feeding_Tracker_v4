module KibblePrices
  # Finds current Taiwan prices for a pet's favorite kibbles and ranks each
  # kibble's listings by NT$ per kg, cheapest first.
  class Lookup
    PRICE_RANGE = 50..20_000
    MAX_PRICES = 8
    SOURCES = [ BigGoSearch, PchomeSearch ].freeze

    def initialize(pet, **favorite_options)
      @pet = pet
      @favorite_options = favorite_options
    end

    # One entry per favorite kibble: { kibble:, queries:, prices:, rejected: }.
    # rejected counts the listings each rule left out, for reviewing the matching.
    # prices is empty when neither BigGo nor PChome lists the kibble.
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

      { kibble: kibble, queries: queries, prices: rank(rows), rejected: rejected }
    end

    def price_row(listing)
      # The variant's size when it names one, since the price is for that variant.
      size = BagSize.parse(listing.variant) || (BagSize.parse(listing.title) unless listing.variant.to_s.match?(BagSize::SIZE))
      return if size.nil?

      listing.to_h.merge(bag_size_label: size[:label], bag_size_kg: size[:kg],
                         price_per_kg: (listing.price_twd / size[:kg]).round(1))
    end

    # The cheapest listing per shop and bag size, and each shop page once.
    def rank(rows)
      rows.sort_by { |row| row[:price_per_kg] }
          .uniq { |row| [ row[:store], row[:bag_size_kg] ] }
          .uniq { |row| row[:url] }
          .first(MAX_PRICES)
    end
  end
end
