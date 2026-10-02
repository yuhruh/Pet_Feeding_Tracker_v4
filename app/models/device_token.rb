# A phone's Firebase Cloud Messaging token (checkpoint I), registered by the
# Android app for the person signed in on it, in that sign-in session.
class DeviceToken < ApplicationRecord
  PLATFORMS = %w[android].freeze

  belongs_to :user
  belongs_to :session, optional: true

  validates :token, presence: true, uniqueness: true, length: { maximum: 4096 }
  validates :platform, inclusion: { in: PLATFORMS }

  # Registers the token for this person and session; a phone that someone else
  # signed in on before hands it over.
  def self.register(user:, session:, token:, platform: "android")
    record = find_or_initialize_by(token: token.to_s)
    record.assign_attributes(user: user, session: session, platform: platform, last_used_at: Time.current)
    record.save
    record
  rescue ActiveRecord::RecordNotUnique
    retry
  end
end
