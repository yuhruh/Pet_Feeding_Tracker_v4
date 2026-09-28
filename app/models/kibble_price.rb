# One shop's price for a favorite kibble, found by a KibblePriceCheck.
class KibblePrice < ApplicationRecord
  belongs_to :kibble_price_check

  # BigGo and PChome show the shop's listed price; Gemini's comes from Google's
  # index, may be out of date, and is shown as unverified.
  enum :source, { biggo: "BigGo", pchome: "PChome", gemini: "Gemini" }, validate: true

  validates :brand, :description, :product_title, :bag_size_label, presence: true
  validates :price_twd, numericality: { only_integer: true, greater_than: 0 }
  validates :bag_size_kg, :price_per_kg, numericality: { greater_than: 0 }

  scope :ranked, -> { where(suspicious: false).order(:price_per_kg, :id) }
  scope :flagged, -> { where(suspicious: true).order(:price_per_kg, :id) }

  def verified?
    !gemini?
  end
end
