# One owner's cats, food bags, litter boxes and water spots, and the people the
# owner lets help (caregivers and viewers). A user owns at most one household.
class Household < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :pets, dependent: :destroy
  has_many :dry_foods, dependent: :destroy
  has_many :care_spots, -> { order(:position, :id) }, dependent: :destroy
  has_many :memberships, class_name: "HouseholdMembership", dependent: :destroy
  has_many :members, through: :memberships, source: :user
  has_many :invitations, class_name: "HouseholdInvitation", dependent: :destroy
  has_many :viewer_links, dependent: :destroy
  has_many :ownership_transfers, dependent: :destroy

  validates :owner_id, uniqueness: true

  # Every household starts with one litter box and one water bowl, so a one-box
  # home never has to set anything up.
  after_create :create_default_care_spots

  # The owner's household, created the first time they add a pet or a food bag.
  def self.for_owner(user)
    user.owned_household || user.create_owned_household!
  rescue ActiveRecord::RecordNotUnique
    user.reload.owned_household
  end

  private

  def create_default_care_spots
    care_spots.create!(kind: :litter_box, position: 0)
    care_spots.create!(kind: :water_bowl, position: 1)
  end
end
