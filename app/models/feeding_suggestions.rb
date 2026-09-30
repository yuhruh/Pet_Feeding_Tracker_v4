# What to suggest for brand and description when adding feeding details, by food
# type, from the cat's own household only: its food bags (kibble, freeze-dried),
# the cat's favorite wet foods, and what the cat has had before ("other").
class FeedingSuggestions
  def initialize(pet)
    @pet = pet
    @household = pet.household
  end

  def by_food_type
    {
      "kibble" => bags(:kibble),
      "freeze_dried" => bags(:freeze_dried),
      "wet" => favorite_wet_foods,
      "other" => past_other_foods
    }
  end

  private

  def bags(food_type)
    @household.dry_foods.where(food_type: DryFood.food_types[food_type]).where("left_amount > 0").order(updated_at: :desc).map do |bag|
      { label: I18n.t("care_events.suggestions.bag", food: "#{bag.brand} #{bag.description}", left: bag.left_amount.to_f.round),
        brand: bag.brand, description: bag.description, dry_food_id: bag.id }
    end
  end

  def favorite_wet_foods
    @pet.favorite_foods(food_type: "wet").select { |food| food[:results].first[:favorite_score] >= 30 }.first(15).map do |food|
      { label: I18n.t("care_events.suggestions.favorite", food: "#{food[:brand]} #{food[:description]}", date: food[:results].first[:date]),
        brand: food[:brand], description: food[:description] }
    end
  end

  def past_other_foods
    from_trackers = @pet.trackers.other.order(date: :desc).limit(50).pluck(:brand, :description)
    from_taps = @pet.care_events.kept.fed.order(occurred_at: :desc).limit(50).map(&:details)
                    .select { |details| details["food_type"] == "other" }.map { |details| details.values_at("brand", "description") }
    (from_trackers + from_taps).map { |pair| pair.map(&:to_s) }.uniq.reject { |brand, _| brand.blank? }.first(15).map do |brand, description|
      { label: "#{brand} #{description}".strip, brand: brand, description: description }
    end
  end
end
