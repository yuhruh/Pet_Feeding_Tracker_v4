# A phone's Firebase Cloud Messaging token (checkpoint I), registered by the
# Android app for the person signed in on it, in that sign-in session.
class DeviceToken < ApplicationRecord
  PLATFORMS = %w[android].freeze

  belongs_to :user
  belongs_to :session, optional: true

  # Phones that show Pet Tracker's notifications, as the app last reported.
  scope :notifying, -> { where(notifications_allowed: true) }

  validates :token, presence: true, uniqueness: true, length: { maximum: 4096 }
  validates :platform, inclusion: { in: PLATFORMS }

  # Registers the token for this person and session; a phone that someone else
  # signed in on before hands it over. notifications_allowed is nil when the app
  # didn't say (versions before 1.0.7 only sent a token when they were allowed).
  def self.register(user:, session:, token:, platform: "android", notifications_allowed: nil)
    record = find_or_initialize_by(token: token.to_s)
    record.assign_attributes(user: user, session: session, platform: platform, last_used_at: Time.current)
    record.notifications_allowed = notifications_allowed unless notifications_allowed.nil?
    record.save
    record
  rescue ActiveRecord::RecordNotUnique
    retry
  end
end
