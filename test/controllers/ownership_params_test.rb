require "test_helper"

# Ownership fields sent in a form must never move a record to another user
# or pet. Signed in as users(:one); users(:two) owns pets(:two) and dry_foods(:two).
class OwnershipParamsTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as(users(:one))
    @pet = pets(:one)
    @other_user = users(:two)
    @other_pet = pets(:two)
    @other_dry_food = dry_foods(:two)
  end

  test "creating a pet ignores a submitted user_id" do
    assert_difference("Pet.count") do
      post pets_url, params: { pet: { petname: "Mochi", user_id: @other_user.id } }
    end
    assert_equal users(:one), Pet.order(:id).last.user
    assert_empty @other_user.pets.where(petname: "Mochi")
  end

  test "updating a pet ignores a submitted user_id" do
    patch pet_url(@pet), params: { pet: { petname: "Mochi", user_id: @other_user.id } }
    assert_equal users(:one), @pet.reload.user
  end

  test "creating a dry food ignores a submitted user_id" do
    assert_difference("DryFood.count") do
      post dry_foods_url, params: { dry_food: { brand: "Orijen", food_type: "kibble", description: "Six Fish", amount: 1800, user_id: @other_user.id } }
    end
    assert_equal users(:one), DryFood.order(:id).last.user
  end

  test "restocking a dry food ignores a submitted user_id" do
    patch restock_dry_food_url(dry_foods(:one)), params: { dry_food: { amount: 2000, user_id: @other_user.id } }
    assert_equal users(:one), dry_foods(:one).reload.user
  end

  test "creating a tracker ignores a submitted pet_id" do
    assert_no_difference -> { @other_pet.trackers.count } do
      assert_difference -> { @pet.trackers.count } do
        post pet_trackers_url(@pet), params: { tracker: tracker_attrs.merge(pet_id: @other_pet.id) }
      end
    end
  end

  test "updating a tracker ignores a submitted pet_id" do
    tracker = trackers(:one)
    patch pet_tracker_url(@pet, tracker), params: { tracker: { note: "moved?", pet_id: @other_pet.id, dry_food_id: tracker.dry_food_id } }
    assert_equal @pet, tracker.reload.pet
  end

  test "a new tracker cannot draw from another user's dry food" do
    left_before = @other_dry_food.left_amount
    assert_no_difference("Tracker.count") do
      post pet_trackers_url(@pet), params: { tracker: tracker_attrs.merge(food_type: "kibble", dry_food_id: @other_dry_food.id) }
    end
    assert_response :unprocessable_entity
    assert_equal left_before, @other_dry_food.reload.left_amount
  end

  test "an existing tracker cannot be switched to another user's dry food" do
    tracker = trackers(:one)
    patch pet_tracker_url(@pet, tracker), params: { tracker: { dry_food_id: @other_dry_food.id } }
    assert_response :unprocessable_entity
    assert_equal dry_foods(:one), tracker.reload.dry_food
  end

  test "a tracker can still draw from the owner's own dry food" do
    assert_difference("Tracker.count") do
      post pet_trackers_url(@pet), params: { tracker: tracker_attrs.merge(food_type: "kibble", dry_food_id: dry_foods(:one).id) }
    end
    assert_equal dry_foods(:one), Tracker.order(:id).last.dry_food
  end

  test "creating a health check ignores a submitted pet_id" do
    assert_no_difference -> { @other_pet.health_checks.count } do
      assert_difference -> { @pet.health_checks.count } do
        post pet_health_checks_url(@pet), params: { health_check: { exam_date: Date.current, crea: 1.2, pet_id: @other_pet.id } }
      end
    end
  end

  test "updating a health check ignores a submitted pet_id" do
    health_check = health_checks(:one)
    patch pet_health_check_url(@pet, health_check), params: { health_check: { crea: 1.5, pet_id: @other_pet.id } }
    assert_equal @pet, health_check.reload.pet
  end

  private
    def tracker_attrs
      { date: Date.current, feed_time: "08:30", food_type: "wet", brand: "Ciao", description: "Tuna", amount: 40 }
    end
end
