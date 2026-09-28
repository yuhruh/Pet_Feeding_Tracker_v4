# One shop's listed price for a favorite kibble, found by a KibblePriceCheck.
class KibblePrice < ApplicationRecord
  belongs_to :kibble_price_check

  # Where the listing was found: BigGo's price comparison or PChome's own search.
  enum :source, { biggo: "BigGo", pchome: "PChome" }, validate: true

  validates :brand, :description, :product_title, :bag_size_label, presence: true
  validates :price_twd, numericality: { only_integer: true, greater_than: 0 }
  validates :bag_size_kg, :price_per_kg, numericality: { greater_than: 0 }

  scope :ranked, -> { order(:price_per_kg, :id) }
end
