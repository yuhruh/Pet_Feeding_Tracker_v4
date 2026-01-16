require "test_helper"

class TrackersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pet = pets(:one)
    @tracker = @pet.trackers.create(date: "2026-01-01", feed_time: "10:02", hungry: "💖 Yes, eat right away",
    come_back_to_eat: "21:29, 00:24, 4:46", food_type: "Wet", brand: "Ciao", description: "imc-222 果凍杯 鮪魚+雞肉+干貝 x3",
    amount: 105, left_amount: 40, total_ate_amount: 65)
    @user = User.create(email_address: "example@email.com", password: "password", password_confirmation: "password", username: "John Doe", timezone: "Asia/Taipei")
    post session_url, params: { email_address: @user.email_address, password: "password" }
  end

  test "should get index" do
    get pet_trackers_url(@pet)
    assert_response :success
  end

  test "should get new" do
    get new_pet_tracker_url(@pet)
    assert_response :success
  end

  test "should create tracker" do
    assert_difference("Tracker.count") do
      post pet_trackers_url(@pet), params: { tracker: { amount: @tracker.amount, brand: @tracker.brand, date: @tracker.date, description: @tracker.description, dry_food_id: @tracker.dry_food_id, favorite_score: @tracker.favorite_score, feed_time: @tracker.feed_time, food_type: @tracker.food_type, frequency: @tracker.frequency, hungry: @tracker.hungry, left_amount: @tracker.left_amount, love: @tracker.love, note: @tracker.note, pet_id: @tracker.pet_id, result: @tracker.result, total_ate_amount: @tracker.total_ate_amount, weight: @tracker.weight } }
    end

    assert_redirected_to pet_trackers_url(@pet)
  end

  # test "should show tracker" do
  #   get pet_tracker_url(@pet, @tracker)
  #   assert_response :success
  # end

  test "should get edit" do
    get edit_pet_tracker_url(@pet, @tracker)
    assert_response :success
  end

  test "should update tracker" do
    patch pet_tracker_url(@pet, @tracker), params: { tracker: { come_back_to_eat: @tracker.come_back_to_eat, date: @tracker.date, description: @tracker.description, dry_food_id: @tracker.dry_food_id, favorite_score: @tracker.favorite_score, feed_time: @tracker.feed_time, food_type: @tracker.food_type, frequency: @tracker.frequency, hungry: @tracker.hungry, left_amount: @tracker.left_amount, love: @tracker.love, note: @tracker.note, pet_id: @tracker.pet_id, result: @tracker.result, total_ate_amount: @tracker.total_ate_amount, weight: @tracker.weight } }
    assert_redirected_to pet_trackers_url(@pet)
  end

  test "should destroy tracker" do
    assert_difference("Tracker.count", -1) do
      delete pet_tracker_url(@pet, @tracker)
    end

    assert_redirected_to pet_trackers_url(@pet)
  end
end
