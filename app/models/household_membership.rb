# A caregiver or an account viewer in someone else's household. The owner is
# Household#owner, not a membership.
class HouseholdMembership < ApplicationRecord
  belongs_to :household
  belongs_to :user

  enum :role, { caregiver: "caregiver", viewer: "viewer" }, validate: true

  validates :user_id, uniqueness: { scope: :household_id }
  validate :not_the_owner

  private

  def not_the_owner
    errors.add(:user, :taken) if household && user_id == household.owner_id
  end
end
