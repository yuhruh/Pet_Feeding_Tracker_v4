# One price check of a pet's favorite kibbles: the monthly run, or "Refresh now".
class KibblePriceCheck < ApplicationRecord
  belongs_to :pet
  has_many :kibble_prices, dependent: :destroy

  enum :status, { pending: "pending", done: "done", failed: "failed" }, validate: true

  validates :checked_on, presence: true, uniqueness: { scope: :pet_id }

  scope :latest_first, -> { order(checked_on: :desc, id: :desc) }

  # The prices of one kibble from this check, cheapest per kg first.
  def prices_for(brand, description)
    kibble_prices.ranked.where(brand: brand, description: description)
  end
end
