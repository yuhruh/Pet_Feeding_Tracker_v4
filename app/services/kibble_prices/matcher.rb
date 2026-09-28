module KibblePrices
  # Decides whether a shop listing sells one favorite kibble. Shops word things
  # differently from owners ("室內貓雙響宴" vs "室內雙饗宴"), so the description is
  # compared character by character instead of as one phrase.
  #
  # A listing has a title and, when it sells several variants, the variant the
  # price is for ("鴨肉｜體態管理配方 2kg"). The variant must not be a different food.
  class Matcher
    # Share of the description's characters the listing must contain.
    MIN_COVERAGE = 0.7
    # Share of the variant's characters that must come from the kibble's name.
    MIN_VARIANT_AGREEMENT = 0.5

    # Words for what kind of product it is, not which one: they do not count
    # toward a match. 全 stays, as 全齡 (all ages) tells formulas apart.
    FILLER_CHARS = "貓狗犬的配方食譜糧飼料乾包袋入組個件罐裝款口味新鮮和與及專用".chars.to_set.freeze
    # Shop wording that says nothing about the food itself.
    SHOP_NOISE = /超商|超取|宅配|免運|現領|\d*折|限\s*\d*\s*[包件袋]?|最多\s*\d*\s*[包件袋]?|預購|促銷|新上市|附發票|蝦幣回饋|回饋/
    # Short-dated or repacked stock is not a fair price for the food.
    REJECT_WORDS = /即期|效期|過期|分裝|二手|試吃/
    SIZES = /\d+(?:\.\d+)?\s*(?:公斤|公克|kg|lbs|lb|g|克|磅)(?![a-z])/i
    # Product-line codes such as IN27, IN+7, K36, L40.
    CODE = /(?<![a-z0-9])(?!x\d)[a-z]{1,3}\+?\d{1,3}\+?(?![a-z0-9])/i
    # Proteins tell flavors apart ("無穀滋養鴨肉" vs "無穀滋養雞肉"), so every one the
    # owner named must be in the listing. 火雞 (turkey) is listed before 雞 (chicken)
    # so "火雞肉" does not also count as chicken.
    PROTEIN = /火雞|turkey|袋鼠|kangaroo|沙丁|sardine|雞|chicken|鴨|duck|鵝|goose|牛|beef|羊|lamb|鹿|venison|豬|pork|兔|rabbit|鮭|salmon|鮪|tuna|鱈|cod|鯡|herring|鯖|mackerel|虱目魚|milkfish|魚|fish|蝦|shrimp/i
    PROTEIN_NAMES = {
      "turkey" => "火雞", "kangaroo" => "袋鼠", "sardine" => "沙丁", "chicken" => "雞", "duck" => "鴨",
      "goose" => "鵝", "beef" => "牛", "lamb" => "羊", "venison" => "鹿", "pork" => "豬", "rabbit" => "兔",
      "salmon" => "鮭", "tuna" => "鮪", "cod" => "鱈", "herring" => "鯡", "mackerel" => "鯖",
      "milkfish" => "虱目魚", "fish" => "魚", "shrimp" => "蝦"
    }.freeze
    CAT = /貓|cat|kitten/i
    DOG = /犬|狗|dog|puppy/i

    # brand_names: every name the brand goes by (see BrandNames); by default the
    # names in the kibble's own brand field.
    def initialize(kibble, species: nil, brand_names: nil)
      @brand = Query.brand(kibble)
      @brand_names = brand_names || BrandNames.split(kibble[:dry_food]&.brand.presence || kibble[:brand])
      @description = Query.description(kibble)
      @species = species
      @description_chars = meaningful(@description)
      @name_chars = meaningful("#{@brand} #{@description}")
      @codes = codes(@description)
      @proteins = proteins(@description)
    end

    def match?(title:, variant: nil)
      rejection(title: title, variant: variant).nil?
    end

    # Why the listing is not this kibble, or nil when it is. Kept as a symbol so a
    # console run can show what each rule filtered out.
    def rejection(title:, variant: nil)
      title = normalize(title)
      variant = normalize(variant)
      listing = "#{title} #{variant}"

      return :reject_word if listing.match?(REJECT_WORDS)
      return :brand unless BrandNames.in?(@brand_names, listing)
      return :species if other_species?(listing)
      return :protein unless @proteins.subset?(proteins(listing))
      return :code if @codes.any? && (codes(listing) & @codes).empty?
      return :coverage if coverage(listing) < MIN_COVERAGE
      return :variant unless variant_agrees?(variant)

      nil
    end

    private

    def normalize(text)
      text.to_s.unicode_normalize(:nfkc).downcase
    end

    def other_species?(listing)
      return false if @species.nil?

      cat, dog = listing.match?(CAT), listing.match?(DOG)
      @species == :cat ? dog && !cat : cat && !dog
    end

    def coverage(listing)
      return 1.0 if @description_chars.empty?

      listing_chars = meaningful(listing)
      (@description_chars & listing_chars).size.fdiv(@description_chars.size)
    end

    # A variant such as "(原野收穫),1.36KG" names a different food than the owner's,
    # even when the title lists every flavor the shop sells.
    def variant_agrees?(variant)
      return true if variant.blank?
      return false if @codes.any? && (codes(variant) - @codes).any?

      # Brackets often hold the ingredients; judge by the name outside them when there is one.
      outside = variant.gsub(/\([^)]*\)/, " ")
      chars = meaningful(outside).size >= 2 ? meaningful(outside) : meaningful(variant)
      return true if chars.size < 2

      (chars & @name_chars).size.fdiv(chars.size) >= MIN_VARIANT_AGREEMENT
    end

    # The characters (Chinese) and words (English, codes) that say which food it is.
    def meaningful(text)
      text = normalize(text).gsub(SHOP_NOISE, " ").gsub(SIZES, " ")
      words = text.scan(/[a-z][a-z0-9+']+/)
      cjk = text.scan(/\p{Han}/).reject { |c| FILLER_CHARS.include?(c) }
      (words + cjk).to_set
    end

    def proteins(text)
      normalize(text).scan(PROTEIN).map { |name| PROTEIN_NAMES.fetch(name, name) }.to_set
    end

    def codes(text)
      normalize(text).scan(CODE).map { |code| code.delete("+") }.to_set
    end
  end
end
