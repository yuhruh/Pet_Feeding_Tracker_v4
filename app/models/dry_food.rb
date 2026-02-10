class DryFood < ApplicationRecord
  belongs_to :user
  has_many :trackers, dependent: :nullify

  enum :food_type, { kibble: "Kibble", freeze_dried: "Freeze-Dried" }

  before_create :set_left_amount

  def brand_with_description
    "#{brand} - #{description}"
  end

  private

  def set_left_amount
    self.left_amount = amount
  end
end
