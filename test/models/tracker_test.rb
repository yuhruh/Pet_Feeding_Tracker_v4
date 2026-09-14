require "test_helper"

class TrackerTest < ActiveSupport::TestCase
  test "feed_time_offset uses the zone's offset on 2000-01-01, the date Rails stores times on" do
    assert_equal 8 * 3600, Tracker.feed_time_offset("Asia/Taipei")
    assert_equal(-5 * 3600, Tracker.feed_time_offset("America/New_York"))
    assert_equal 5 * 3600 + 30 * 60, Tracker.feed_time_offset("Asia/Kolkata")
    assert_equal 5 * 3600 + 45 * 60, Tracker.feed_time_offset("Asia/Kathmandu")
    assert_equal 11 * 3600, Tracker.feed_time_offset("Australia/Sydney")
  end

  test "unknown or crafted zones fall back to UTC and never reach the SQL" do
    [ "Asia/Taipei') DESC; DROP TABLE users; --", "Not/AZone", "", nil ].each do |zone|
      assert_equal 0, Tracker.feed_time_offset(zone), "unexpected offset for #{zone.inspect}"
      assert_no_match(/DROP|AZone/, Tracker.local_feed_time_sql(zone))
    end
  end

  test "ordering by local_feed_time_sql follows the local clock, including past midnight" do
    pet = pets(:one)
    %w[Asia/Taipei America/New_York Asia/Kolkata Australia/Sydney].each do |zone|
      ids = Time.use_zone(zone) do
        %w[09:25 00:20 23:50 12:00].map do |time|
          pet.trackers.create!(date: "2026-05-01", feed_time: time, food_type: "wet", brand: "Ciao", description: "Tuna", amount: 40).id
        end
      end
      sorted = Tracker.where(id: ids).order(Arel.sql("#{Tracker.local_feed_time_sql(zone)} DESC"))
      local_times = sorted.map { |t| t.feed_time.in_time_zone(zone).strftime("%H:%M") }
      assert_equal %w[23:50 12:00 09:25 00:20], local_times, "wrong order for #{zone}"
    end
  end
end
