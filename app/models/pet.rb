class Pet < ApplicationRecord
  has_one_attached :pet_avatar
  belongs_to :user
  validates :petname, presence: true,
                      length: { minimum: 2, maximum: 25 }
end
