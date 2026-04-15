class Pet < ApplicationRecord
  has_one_attached :pet_avatar
  belongs_to :user
  has_many :trackers, dependent: :destroy
  has_many :health_checks, dependent: :destroy
  validates :petname, presence: true,
                      length: { minimum: 2, maximum: 25 }

  before_create :generate_share_token

  private

  def generate_share_token
    self.share_token = SecureRandom.urlsafe_base64(16) if share_token.blank?
  end
end
