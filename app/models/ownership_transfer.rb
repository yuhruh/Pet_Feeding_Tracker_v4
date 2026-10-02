# An owner handing their household to one of its members. The member must accept
# within 7 days; the former owner then stays on as a caregiver.
class OwnershipTransfer < ApplicationRecord
  include SecretToken

  VALID_FOR = 7.days

  belongs_to :household
  belongs_to :from_user, class_name: "User"
  belongs_to :to_user, class_name: "User"

  validate :to_a_member_who_owns_nothing, on: :create
  before_validation(on: :create) { self.expires_at ||= VALID_FOR.from_now }

  scope :pending, -> { where(accepted_at: nil, cancelled_at: nil).where("expires_at > ?", Time.current) }

  def pending?
    accepted_at.nil? && cancelled_at.nil? && expires_at > Time.current
  end

  def cancel!
    update!(cancelled_at: Time.current)
  end

  # In one transaction: the member becomes the owner (their membership goes), the
  # former owner becomes a caregiver, and the cats and food bags follow the new
  # owner. Returns false (with errors) when it can't happen.
  def accept!(user)
    errors.clear
    return reject(:not_pending) unless pending?
    return reject(:wrong_person) unless user&.id == to_user_id
    return reject(:still_owner_changed) unless household.owner_id == from_user_id
    return reject(:already_owns) if Household.where(owner_id: to_user_id).exists?

    transaction do
      household.lock!
      household.memberships.where(user_id: to_user_id).destroy_all
      household.update!(owner_id: to_user_id)
      household.memberships.create!(user_id: from_user_id, role: :caregiver)
      household.ownership_transfers.pending.where.not(id: id).update_all(cancelled_at: Time.current)
      update!(accepted_at: Time.current)
    end
    true
  end

  private

  def reject(reason)
    errors.add(:base, reason)
    false
  end

  def to_a_member_who_owns_nothing
    return if household.nil? || to_user_id.nil?

    errors.add(:to_user, :not_a_member) unless household.memberships.exists?(user_id: to_user_id)
    errors.add(:to_user, :already_owns) if Household.where(owner_id: to_user_id).exists?
  end
end
