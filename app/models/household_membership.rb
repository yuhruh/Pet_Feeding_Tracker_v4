# A caregiver or an account viewer in someone else's household. The owner is
# Household#owner, not a membership.
class HouseholdMembership < ApplicationRecord
  belongs_to :household
  belongs_to :user

  enum :role, { caregiver: "caregiver", viewer: "viewer" }, validate: true

  validates :user_id, uniqueness: { scope: :household_id }
  validate :not_the_owner
  # Someone who leaves or is removed can no longer take over the household.
  after_destroy :cancel_offers_to_this_member

  private

  def cancel_offers_to_this_member
    household.ownership_transfers.pending.where(to_user_id: user_id).update_all(cancelled_at: Time.current)
  end

  def not_the_owner
    errors.add(:user, :taken) if household && user_id == household.owner_id
  end
end
