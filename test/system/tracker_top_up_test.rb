require "application_system_test_case"

class TrackerTopUpTest < ApplicationSystemTestCase
  test "the new-feeding form asks for the last leftover and counts only the top-up" do
    bag = dry_foods(:one)
    # Only this bag is kibble, so it is the one the form lists.
    DryFood.where(household: bag.household).where.not(id: bag.id).update_all(food_type: "Freeze-Dried")
    bag.update_columns(amount: 100)
    Tracker.where(dry_food: bag).delete_all
    pet = pets(:one)
    morning = pet.trackers.create!(dry_food: bag, food_type: "kibble", brand: "brand", description: "kibble", date: Date.current, feed_time: "08:00", amount: 25)
    bag.reload.update_columns(left_amount: 15) # a nearly empty bag

    sign_in_as(users(:one))
    visit new_pet_tracker_url(pet, locale: :en)
    select "Kibble", from: "tracker_food_type"
    find("[data-tracker-form-target=dryFoodSelect] option[value='#{bag.id}']").select_option

    assert_text "Left in the bowl from the last feeding"
    assert_no_text "Threw away what was left in the bowl"
    find("[data-tracker-form-target=amount]").set("25")
    assert_text "Only 15g left in storage."

    find("#last_feeding_left_amount").set("14.5")
    assert_text "Tops up the 14.5g still in the bowl, so 10.5g comes from the bag."
    assert_text "Threw away what was left in the bowl"

    check "discard_bowl_leftover"
    assert_text "Only 15g left in storage."
    uncheck "discard_bowl_leftover"

    find("#last_feeding_left_amount").set("30")
    assert_text "no more than that can be left"
    find("#last_feeding_left_amount").set("14.5")

    select "💖 Yes, eat right away", from: "tracker_hungry"
    find("[data-tracker-form-target=submitButton]").click
    assert_text "Tracker was successfully created."
    assert_equal 14.5, morning.reload.left_amount
  end
end
