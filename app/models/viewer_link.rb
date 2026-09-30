# A personal read-only link to a household's viewer page, for one viewer, with no
# account needed. The owner can turn it off at any time; it may also expire.
class ViewerLink < ApplicationRecord
  include SecretToken

  belongs_to :household
  belongs_to :created_by, class_name: "User", optional: true

  validates :name, presence: true, length: { maximum: 40 }
  validate :expiry_in_the_future, on: :create

  scope :active, -> { where(revoked_at: nil).where("expires_at IS NULL OR expires_at > ?", Time.current) }

  def self.find_active(token)
    active.find_by(token_digest: digest(token)) if token.present?
  end

  def active?
    revoked_at.nil? && (expires_at.nil? || expires_at > Time.current)
  end

  def revoke!
    update!(revoked_at: Time.current)
  end

  # Updated at most once an hour, so opening the page doesn't write every time.
  def record_use!
    update_column(:last_used_at, Time.current) if last_used_at.nil? || last_used_at < 1.hour.ago
  end

  private

  def expiry_in_the_future
    errors.add(:expires_at, :in_the_past) if expires_at && expires_at <= Time.current
  end
end
