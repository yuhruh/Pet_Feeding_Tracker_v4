require "test_helper"

class TrackersHelperTest < ActionView::TestCase
  # pets(:one) belongs to users(:one), who is in Asia/Taipei:
  # 00:20 is stored as 16:20 UTC and 09:25 as 01:25 UTC.
  test "first occurrence of a food follows the local clock, not UTC" do
    pet = pets(:one)
    midnight_feed, morning_feed = Time.use_zone(pet.timezone) do
      %w[00:20 09:25].map do |time|
        pet.trackers.create!(date: "2026-05-01", feed_time: time, food_type: "wet", brand: "New Brand", description: "First Try", amount: 40)
      end
    end

    assert first_occurrence?(midnight_feed), "00:20 was the first feeding of this food that day"
    assert_not first_occurrence?(morning_feed)
  end
end
