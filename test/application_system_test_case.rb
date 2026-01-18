require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  def sign_in_as(user)
    visit new_session_url
    assert_selector "h1", text: /Sign In Cat Trackers App/i

    find("#email_address").set(user.email_address)
    find("#password").set("password123")

    click_on "Sign in"

    if user.sign_in_count.to_i > 1
      assert_selector "h1", text: /#{user.username}'s cat list/i
      assert_text "Welcome back to Cat Feeding Tracker, #{user.username.capitalize}"
    else
      assert_selector "h1", text: "Add A Cat"
      assert_text "Hello, #{user.username.capitalize} 👋. This is your first time to sign in, please add a new cat first for further tracker."
    end
  end
end
