class Pet < ApplicationRecord
  has_one_attached :pet_avatar
  belongs_to :user
  has_many :trackers, dependent: :destroy
  has_many :health_checks, dependent: :destroy
  validates :petname, presence: true,
                      length: { minimum: 2, maximum: 25 }

  before_create :generate_share_token

  def share_token
    # If the token is missing in the database, generate it, save it, and return it.
    if read_attribute(:share_token).blank?
      new_token = SecureRandom.urlsafe_base64(16)
      update_column(:share_token, new_token)
      new_token
    else
      read_attribute(:share_token)
    end
  end

  private

  def generate_share_token
    self.share_token = SecureRandom.urlsafe_base64(16) if read_attribute(:share_token).blank?
  end
end
