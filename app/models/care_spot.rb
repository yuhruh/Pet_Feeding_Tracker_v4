# A litter box or water spot in a household. Care for them is shared, not per cat.
class CareSpot < ApplicationRecord
  belongs_to :household
  has_many :care_events, dependent: :delete_all

  enum :kind, { litter_box: "litter_box", water_bowl: "water_bowl", water_fountain: "water_fountain" }, validate: true

  scope :active, -> { where(archived_at: nil) }
end
