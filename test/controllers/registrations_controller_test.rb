require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_registrations_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post registrations_url, params: { user: { username: "new_user", email_address: "new_user@example.com", email_address_confirmation: "new_user@example.com", password: "password", password_confirmation: "password", timezone: "UTC" } }
    end
    follow_redirect!
    assert_response :success
    assert_equal "Hello, New_user 👋. You've successfully signed up to Cat Feeding Tracker App and
                                      this is your first time to sign in, please add a new cat first for further tracker.
                                      Welcome New_user!", flash[:notice]
  end

  test "should not create user with invalid params" do
    assert_no_difference("User.count") do
      post registrations_url, params: { user: { username: "", email_address: "new_user@example.com", email_address_confirmation: "new_user@example.com", password: "password", password_confirmation: "password", timezone: "UTC" } }
    end

    assert_response :unprocessable_entity
  end
end
