module KibblePrices
  # The search texts for one favorite kibble (a Pet#favorite_kibbles entry).
  module Query
    # The bag's own name is what the owner typed when buying it, so it wins over the tracker's.
    def self.brand(kibble)
      clean(kibble[:dry_food]&.brand.presence || kibble[:brand])
    end

    def self.description(kibble)
      clean(kibble[:dry_food]&.description.presence || kibble[:description])
    end

    # Most specific first. Shops rarely use the owner's exact wording, so the second
    # search is the brand alone and Matcher picks the right listings from it.
    def self.for(kibble, species: nil)
      food = { cat: "貓飼料", dog: "狗飼料" }.fetch(species, "飼料")
      [ "#{brand(kibble)} #{description(kibble)}", "#{brand(kibble)} #{food}" ].map(&:squish).uniq
    end

    # Drops a trailing count ("x3", "（x3）") the same way the favorite-food list does,
    # and punctuation that only narrows a search.
    def self.clean(text)
      text.to_s.unicode_normalize(:nfkc)
          .gsub(/\s*[(\s]*[x×]\s*\d+[)\s]*\z/i, "")
          .gsub(/[&+\/|,、，.。:：;；!！?？"'「」【】\[\]()]/, " ")
          .squish
    end
  end
end
