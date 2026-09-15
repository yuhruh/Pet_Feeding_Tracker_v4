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

  test "a new user's password must be at least 8 characters" do
    user = User.new(username: "newbie", email_address: "newbie@example.com", email_address_confirmation: "newbie@example.com", timezone: "Asia/Taipei")
    user.password = user.password_confirmation = "a" * (User::MINIMUM_PASSWORD_LENGTH - 1)
    assert_not user.valid?
    assert user.errors.added?(:password, :too_short, count: User::MINIMUM_PASSWORD_LENGTH)

    user.password = user.password_confirmation = "a" * User::MINIMUM_PASSWORD_LENGTH
    assert user.valid?, user.errors.full_messages.to_sentence
  end

  test "changing to a password shorter than 8 characters is rejected" do
    assert_not @user.update(password: "1234567", password_confirmation: "1234567")
    assert @user.reload.authenticate("password123")
  end

  test "a blank password on update keeps the current one" do
    assert @user.update(username: "renamed", password: "", password_confirmation: "")
    assert @user.reload.authenticate("password123")
  end
end
