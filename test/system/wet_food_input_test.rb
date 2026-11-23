require "application_system_test_case"

class WetFoodInputTest < ApplicationSystemTestCase
  setup do
    @pet = pets(:one)
    [ [ "Ciao", "Tuna & chicken", 85 ], [ "Ciao", "Tuna & scallop", 70 ], [ "Inaba", "Churu tuna", 14 ] ].each do |brand, description, amount|
      @pet.trackers.create!(date: Date.current, feed_time: "08:00", food_type: "Wet", brand: brand, description: description, amount: amount)
    end
  end

  test "wet food offers saved brands, then only the chosen brand's foods, and still takes typed ones" do
    sign_in_as(users(:one))
    visit new_pet_tracker_url(@pet, locale: :en)
    assert_no_selector "#tracker_brand[list]"

    select "Wet", from: "tracker_food_type"
    assert_selector "#tracker_brand[list=wet-brand-list]"
    assert_equal %w[inaba ciao], all("#wet-brand-list option", visible: :all).map(&:value)
    assert_text "Choose a brand first to see its saved foods"

    fill_in "tracker_brand", with: "Ciao"
    assert_equal [ "tuna & scallop", "tuna & chicken" ], all("#wet-description-list option", visible: :all).map(&:value)
    assert_text "Tap to pick one of 2 saved ciao foods"

    fill_in "tracker_brand", with: "Weruva"
    assert_no_selector "#wet-description-list option", visible: :all

    fill_in "tracker_description", with: "Mideast feast"
    fill_in "tracker_amount", with: 85
    select "💖 Yes, eat right away", from: "tracker_hungry"
    find("[data-tracker-form-target=submitButton]").click
    assert_text "Tracker was successfully created."
    assert @pet.trackers.wet.exists?(brand: "weruva", description: "mideast feast")
  end

  test "a saved wet food fills in the amount of its last feeding, but never replaces a typed amount" do
    sign_in_as(users(:one))
    visit new_pet_tracker_url(@pet, locale: :en)
    select "Wet", from: "tracker_food_type"

    fill_in "tracker_brand", with: "Ciao"
    fill_in "tracker_description", with: "tuna & chicken"
    assert_field "tracker_amount", with: "85"
    assert_text "Filled from the last feeding"

    fill_in "tracker_description", with: "tuna & scallop"
    assert_field "tracker_amount", with: "70"

    fill_in "tracker_description", with: "something new"
    assert_field "tracker_amount", with: ""
    assert_no_text "Filled from the last feeding"

    fill_in "tracker_amount", with: 60
    fill_in "tracker_description", with: "tuna & chicken"
    assert_field "tracker_amount", with: "60"
    assert_no_text "Filled from the last feeding"
  end
end
