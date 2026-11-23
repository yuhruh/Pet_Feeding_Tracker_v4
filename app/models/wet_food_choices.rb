# The wet foods the cat's household has logged before, by brand, for the tracker
# form: once a brand is typed or picked, its description offers that brand's
# foods. From every cat in the household, newest first; anything new can still
# be typed by hand.
class WetFoodChoices
  RECENT_FEEDINGS = 500
  # A count at the end, as in "Tuna x2" or "Tuna (×3)", is how many cans, not a different food.
  CAN_COUNT = /\s*[\(\s]*[xX×]\s*\d+[\)\s]*\z/

  def initialize(pet)
    @pet = pet
  end

  # { "ciao" => ["tuna & chicken", "tuna & scallop"], ... }, most recent first.
  # Trackers save brand and description lowercased.
  def by_brand
    feedings.filter_map { |brand, description| [ brand.to_s.squish, clean(description) ] if brand.to_s.squish.present? }
            .group_by(&:first).transform_values { |pairs| pairs.map(&:last).compact_blank.uniq }
  end

  private

  def feedings
    Tracker.wet.where(pet_id: @pet.household.pets.select(:id))
           .order(date: :desc, id: :desc).limit(RECENT_FEEDINGS).pluck(:brand, :description)
  end

  def clean(description)
    description.to_s.tr("（）", "()").sub(CAN_COUNT, "").squish
  end
end
