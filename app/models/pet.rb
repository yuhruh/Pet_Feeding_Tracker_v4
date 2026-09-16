class Pet < ApplicationRecord
  # How long a new share link works. nil means until it is turned off or replaced.
  SHARE_DURATIONS = { "never" => nil, "1_day" => 1.day, "7_days" => 7.days, "30_days" => 30.days }.freeze

  has_one_attached :pet_avatar
  belongs_to :user
  delegate :timezone, to: :user, allow_nil: true
  has_many :trackers, dependent: :destroy
  has_many :health_checks, dependent: :destroy
  has_many :vet_visits, dependent: :destroy
  validates :petname, presence: true,
                      length: { minimum: 2, maximum: 25 }

  # New pets are not shared until the owner turns on a share link.
  scope :shared, -> { where.not(share_token: nil).where("share_expires_at IS NULL OR share_expires_at > ?", Time.current) }

  def self.find_shared!(token)
    shared.find_by!(share_token: token.to_s)
  end

  def sharing?
    share_token.present? && !share_expired?
  end

  def share_expired?
    share_expires_at.present? && share_expires_at <= Time.current
  end

  # Creates a new link, so any earlier link stops working.
  def share!(expires_in: nil)
    update_columns(share_token: SecureRandom.urlsafe_base64(24), share_expires_at: expires_in&.from_now, updated_at: Time.current)
  end

  def stop_sharing!
    update_columns(share_token: nil, share_expires_at: nil, updated_at: Time.current)
  end
end
