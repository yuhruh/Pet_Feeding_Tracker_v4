
require "test_helper"

class TrackerTimezoneTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email_address: "tz@example.com", password: "password", password_confirmation: "password", username: "TZ User", timezone: "Asia/Taipei")
    @pet = @user.pets.create!(petname: "Aji")
    # 12:59 UTC is 20:59 Asia/Taipei
    @tracker = @pet.trackers.create!(
      date: "2024-03-27",
      feed_time: Time.utc(2000, 1, 1, 12, 59),
      food_type: "wet",
      brand: "Test Brand",
      description: "Test Description",
      amount: 100,
      hungry: "eat_right_away"
    )
  end

  test "to_csv uses user timezone for feed_time" do
    csv_output = Tracker.to_csv([ @tracker ], @user.timezone)
    assert_match /20:59/, csv_output
    refute_match /12:59/, csv_output
  end

  test "to_csv defaults to UTC if no timezone provided" do
    csv_output = Tracker.to_csv([ @tracker ])
    assert_match /12:59/, csv_output
  end
end
