# An owner's invitation for one email address to join their household as a
# caregiver. Single use, for that email only, and valid for 7 days.
class HouseholdInvitation < ApplicationRecord
  include SecretToken

  VALID_FOR = 7.days

  belongs_to :household
  belongs_to :invited_by, class_name: "User", optional: true
  belongs_to :accepted_by, class_name: "User", optional: true

  normalizes :email, with: ->(email) { email.strip.downcase }

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :not_the_owner, :not_already_a_member, on: :create

  before_validation(on: :create) { self.expires_at ||= VALID_FOR.from_now }

  scope :pending, -> { where(accepted_at: nil).where("expires_at > ?", Time.current) }

  def pending?
    accepted_at.nil? && !expired?
  end

  def expired?
    expires_at <= Time.current
  end

  def for?(user)
    user && user.email_address == email
  end

  # Makes the user a caregiver, once. Returns false (with errors) when the
  # invitation can't be used by this user.
  def accept!(user)
    errors.clear
    return reject(:not_pending) unless pending?
    return reject(:wrong_email) unless for?(user)
    return reject(:is_owner) if household.owner_id == user.id

    transaction do
      household.memberships.find_or_create_by!(user: user) { |membership| membership.role = :caregiver }
      update!(accepted_at: Time.current, accepted_by: user)
    end
    true
  end

  private

  def reject(reason)
    errors.add(:base, reason)
    false
  end

  def not_the_owner
    errors.add(:email, :is_owner) if household && email == household.owner&.email_address
  end

  def not_already_a_member
    errors.add(:email, :already_member) if household && household.members.exists?(email_address: email)
  end
end
