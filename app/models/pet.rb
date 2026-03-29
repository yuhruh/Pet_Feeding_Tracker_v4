class Pet < ApplicationRecord
  has_one_attached :pet_avatar
  belongs_to :user
  has_many :trackers, dependent: :destroy
  has_many :health_checks, dependent: :destroy
  validates :petname, presence: true,
                      length: { minimum: 2, maximum: 25 }
end
