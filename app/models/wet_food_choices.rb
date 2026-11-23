# The wet foods the cat's household has logged before, by brand, for the tracker
# form: once a brand is typed or picked, its description offers that brand's
# foods, and a saved food fills in the amount from its last feeding. From every
# cat in the household, newest first; anything new can still be typed by hand.
class WetFoodChoices
  RECENT_FEEDINGS = 500
  # A count at the end, as in "Tuna x2" or "Tuna (×3)", is how many cans, not a different food.
  CAN_COUNT = /\s*[\(\s]*[xX×]\s*\d+[\)\s]*\z/

  Feeding = Data.define(:pet_id, :brand, :description, :amount, :date)

  def initialize(pet)
    @pet = pet
  end

  # { "ciao" => [{ description: "tuna & chicken", amount: 85.0, date: "2026/11/21" }, ...], ... },
  # most recent first. The amount is from the last time this cat had the food,
  # otherwise from another cat in the household. Trackers save brand and
  # description lowercased.
  def by_brand
    feedings.group_by { |feeding| [ feeding.brand, feeding.description ] }
            .each_with_object({}) do |((brand, description), group), brands|
      last = group.find { |feeding| feeding.pet_id == @pet.id } || group.first
      (brands[brand] ||= []) << { description: description, amount: last.amount.to_f, date: last.date&.strftime("%Y/%m/%d") }
    end
  end

  private

  def feedings
    Tracker.wet.where(pet_id: @pet.household.pets.select(:id))
           .order(date: :desc, id: :desc).limit(RECENT_FEEDINGS)
           .pluck(:pet_id, :brand, :description, :amount, :date)
           .map { |pet_id, brand, description, amount, date| Feeding.new(pet_id, brand.to_s.squish, clean(description), amount, date) }
           .select { |feeding| feeding.brand.present? && feeding.description.present? }
  end

  def clean(description)
    description.to_s.tr("（）", "()").sub(CAN_COUNT, "").squish
  end
end
