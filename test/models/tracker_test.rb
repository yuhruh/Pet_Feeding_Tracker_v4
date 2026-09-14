require "test_helper"

class TrackerTest < ActiveSupport::TestCase
  test "local_feed_time_sql quotes the resolved IANA zone" do
    expected = "(feed_time AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Taipei')"
    assert_equal expected, Tracker.local_feed_time_sql("Asia/Taipei")
    assert_equal expected, Tracker.local_feed_time_sql("Taipei")
  end

  test "local_feed_time_sql never lets an unknown or crafted zone into the SQL" do
    utc = "(feed_time AT TIME ZONE 'UTC' AT TIME ZONE 'UTC')"
    [ "Asia/Taipei') DESC; DROP TABLE users; --", "Not/AZone", "", nil ].each do |zone|
      assert_equal utc, Tracker.local_feed_time_sql(zone), "unexpected SQL for #{zone.inspect}"
    end
  end
end
