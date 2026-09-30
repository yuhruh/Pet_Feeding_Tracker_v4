require "test_helper"

class HouseholdTest < ActiveSupport::TestCase
  def new_user(name)
    User.create!(username: name, email_address: "#{name}@example.com", email_address_confirmation: "#{name}@example.com",
                 password: "password123", timezone: "Asia/Taipei")
  end

  test "a new household starts with one litter box and one water bowl" do
    household = Household.create!(owner: new_user("mom"))

    assert_equal [ [ "litter_box", 0 ], [ "water_bowl", 1 ] ], household.care_spots.map { |spot| [ spot.kind, spot.position ] }
    assert household.care_spots.all? { |spot| spot.name.nil? && spot.archived_at.nil? }
  end

  test "a user's first pet creates their household, and later pets and food bags join it" do
    mom = new_user("mom")
    assert_nil mom.owned_household

    kuro = mom.pets.create!(petname: "Kuro")
    household = mom.reload.owned_household
    assert_equal household, kuro.household
    assert_equal household, mom.pets.create!(petname: "Shiro").household
    assert_equal household, mom.dry_foods.create!(brand: "曙光", description: "鴨肉", food_type: "kibble", amount: 1000).household
    assert_equal 1, Household.where(owner: mom).count
  end

  test "a user's first food bag creates their household too" do
    mom = new_user("mom")

    bag = mom.dry_foods.create!(brand: "曙光", description: "鴨肉", food_type: "kibble", amount: 1000)

    assert_equal mom.reload.owned_household, bag.household
  end

  test "a pet or food bag can't sit in another owner's household" do
    pet = pets(:one)
    pet.household = households(:two)

    assert_not pet.valid?
    assert_includes pet.errors.details[:household], { error: :invalid }

    bag = dry_foods(:one)
    bag.household = households(:two)
    assert_not bag.valid?
  end

  test "a user owns at most one household" do
    assert_raises(ActiveRecord::RecordInvalid) { Household.create!(owner: users(:one)) }
    assert_equal households(:one), Household.for_owner(users(:one))
  end

  test "deleting a user deletes their household with its pets, food bags and care spots" do
    owner = users(:one)
    household = owner.owned_household
    household.care_spots.create!(kind: :water_fountain, name: "Kitchen fountain", position: 2)

    assert_difference -> { Household.count } => -1, -> { Pet.where(household: household).count } => -1,
                      -> { CareSpot.where(household: household).count } => -1 do
      owner.destroy
    end
    assert_equal 0, DryFood.where(household_id: household.id).count
  end

  test "members are caregivers or viewers, once each, and never the owner" do
    household = households(:one)
    member = users(:two)

    membership = household.memberships.create!(user: member, role: :caregiver)
    assert_equal [ member ], household.members.to_a
    assert_not household.memberships.build(user: member, role: :viewer).valid?, "once per household"
    assert_not household.memberships.build(user: users(:one), role: :viewer).valid?, "the owner isn't a member"
    assert_raises(ActiveRecord::RecordInvalid) { household.memberships.create!(user: new_user("x"), role: :owner) }
    assert membership.caregiver?
  end

  test "care spots are litter boxes, water bowls or fountains" do
    household = households(:one)

    assert household.care_spots.create!(kind: :water_fountain, name: "Kitchen fountain").water_fountain?
    assert_raises(ActiveRecord::RecordInvalid) { household.care_spots.create!(kind: :feeder) }
  end
end
