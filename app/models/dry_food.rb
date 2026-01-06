class DryFood < ApplicationRecord
  belongs_to :user

  before_create :set_left_amount

  def set_left_amount
    self.left_amount = amount
  end
end
