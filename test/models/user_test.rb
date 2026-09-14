require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "accepts IANA and Rails time zone names" do
    [ "Asia/Taipei", "Asia/Tokyo", "UTC", "Taipei" ].each do |zone|
      @user.timezone = zone
      assert @user.valid?, "expected #{zone.inspect} to be accepted"
    end
  end

  test "rejects unknown or crafted time zones" do
    [ "Not/AZone", "Asia/Taipei') DESC; DROP TABLE users; --" ].each do |zone|
      @user.timezone = zone
      assert_not @user.valid?, "expected #{zone.inspect} to be rejected"
      assert @user.errors.added?(:timezone, :invalid)
    end
  end

  test "an existing unknown time zone does not block unrelated updates" do
    @user.update_column(:timezone, "Not/AZone")
    assert @user.update(username: "renamed")
  end
end
