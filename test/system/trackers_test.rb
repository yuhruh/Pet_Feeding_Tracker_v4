require "application_system_test_case"

class TrackersTest < ApplicationSystemTestCase
  include ActionView::RecordIdentifier

  setup do
    @user = users(:one)
    @pet = pets(:one)
    @tracker = trackers(:one)
    @dry_food = dry_foods(:one)
  end

  test "visiting the index" do
    sign_in_as @user
    visit pet_trackers_url(@pet)
    assert_selector "h1", text: "#{@pet.petname.capitalize}'s Trackers"
  end

  test "should create tracker" do
    sign_in_as @user
    visit pet_trackers_url(@pet)
    click_on "New tracker for #{@pet.petname.capitalize}"

    fill_in "tracker_amount", with: @tracker.amount
    fill_in "tracker_brand", with: @tracker.brand
    fill_in "tracker_date", with: @tracker.date
    fill_in "tracker_description", with: @tracker.description
    fill_in "tracker_feed_time", with: @tracker.feed_time
    select @tracker.food_type, from: "tracker_food_type"
    select @tracker.hungry, from: "tracker_hungry"
    click_on "Add a record for #{@pet.petname.capitalize}"

    assert_text "Tracker was successfully created"
  end

  test "should update Tracker" do
    sign_in_as @user
    visit pet_trackers_url(@pet)
    within "##{dom_id(@tracker)}" do
      find("a[href*='edit']").click
    end

    fill_in "tracker_come_back_to_eat", with: "10:00"
    fill_in "tracker_left_amount", with: 5
    select "💕 Love it So Much", from: "tracker_love"
    fill_in "tracker_note", with: "This is a test note."
    fill_in "tracker_weight", with: 5.5
    click_on "Update Record"

    assert_text "Tracker was successfully updated"
  end

  test "should destroy Tracker" do
    sign_in_as @user
    visit pet_trackers_url(@pet)
    accept_confirm do
      within "##{dom_id(@tracker)}" do
        find("a[data-turbo-method='delete']").click
      end
    end

    assert_text "Tracker was successfully destroyed"
  end
end
