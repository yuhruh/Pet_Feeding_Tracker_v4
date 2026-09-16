class Session < ApplicationRecord
  # Signed out after this long without a request, and this long after signing in, whichever comes first.
  IDLE_TIMEOUT = 30.days
  ABSOLUTE_TIMEOUT = 1.year
  # Keeps last_active_at close enough for the idle timeout without a write on every request.
  ACTIVITY_UPDATE_INTERVAL = 1.hour

  belongs_to :user

  before_create { self.last_active_at ||= Time.current }

  scope :expired, -> { where(last_active_at: ...IDLE_TIMEOUT.ago).or(where(created_at: ...ABSOLUTE_TIMEOUT.ago)) }

  def expired?
    last_active_at < IDLE_TIMEOUT.ago || created_at < ABSOLUTE_TIMEOUT.ago
  end

  def expires_at
    created_at + ABSOLUTE_TIMEOUT
  end

  def record_activity
    update_column(:last_active_at, Time.current) if last_active_at < ACTIVITY_UPDATE_INTERVAL.ago
  end
end
