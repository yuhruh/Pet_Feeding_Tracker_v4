module KibblePrices
  # The names a brand goes by, learned from what the owner typed: "喵皇奴 purrsuit"
  # is both 喵皇奴 and purrsuit, and "超躍" plus "超躍 hyperr" makes 超躍 also hyperr.
  module BrandNames
    # Only brands the owner fed lately, so names typed long ago do not linger;
    # the same window that makes a kibble a current favorite.
    WINDOW = Pet::FAVORITE_KIBBLE_WINDOW

    # Chinese runs and Latin runs, each kept whole: "mon petit 貓倍麗" => ["mon petit", "貓倍麗"].
    def self.split(brand)
      text = brand.to_s.unicode_normalize(:nfkc).downcase
      text.scan(/\p{Han}+(?:\s+\p{Han}+)*|[a-z0-9][a-z0-9'&.\-]*(?:\s+[a-z0-9][a-z0-9'&.\-]*)*/)
          .map { |name| name.match?(/\p{Han}/) ? name.delete(" ") : name.squish }
          .to_set
    end

    # Sets of names for the same brand, from the kibble the owner fed in the window,
    # merged whenever two of the owner's entries share a name.
    def self.for_user(user, since: WINDOW.ago)
      trackers = Tracker.kibble.joins(:pet).where(pets: { user_id: user.id }).where(date: since.to_date..)
      brands = trackers.distinct.pluck(:brand) + DryFood.where(id: trackers.select(:dry_food_id)).pluck(:brand)

      brands.map { |brand| split(brand) }.reject(&:empty?).each_with_object([]) do |names, groups|
        overlapping = groups.select { |group| group.intersect?(names) }
        groups.replace(groups - overlapping + [ overlapping.reduce(names, :|) ])
      end
    end

    # Every name of the kibble's brand: its own names, plus any group they belong to.
    def self.for_brand(brand, groups)
      names = split(brand)
      groups.select { |group| group.intersect?(names) }.reduce(names, :|)
    end

    # Chinese names are found anywhere; Latin names only as whole words, so "go"
    # does not match "gogo" and "mon petit" matches "Mon Petit" or "monpetit".
    def self.in?(names, text)
      text = text.to_s.unicode_normalize(:nfkc).downcase
      compact = text.delete(" ")
      names.any? do |name|
        next compact.include?(name) if name.match?(/\p{Han}/)

        pattern = name.split.map { |word| Regexp.escape(word) }.join("\\s*")
        text.match?(/(?<![a-z0-9])#{pattern}(?![a-z0-9])/)
      end
    end
  end
end
