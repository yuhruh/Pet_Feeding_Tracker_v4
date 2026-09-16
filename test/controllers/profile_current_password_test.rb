require "test_helper"
require "minitest/mock"

# Changing the email or password on the profile needs the current password,
# so someone using a stolen session can't lock the owner out.
class ProfileCurrentPasswordTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # password "password123"
    log_in_as @user
  end

  test "the edit form asks for the current password and links to Forgot password" do
    get edit_users_url
    assert_select "input[type=password][name='user[current_password]'][autocomplete='current-password']"
    assert_select "#current_password_hint a[href=?]", new_password_path(locale: I18n.default_locale)
  end

  test "a new password without the current password is refused" do
    patch users_url, params: { user: { password: "new-password1", password_confirmation: "new-password1" } }
    assert_refused
    assert @user.reload.authenticate("password123")
  end

  test "a new password with a wrong current password is refused" do
    patch users_url, params: { user: { password: "new-password1", password_confirmation: "new-password1", current_password: "guess-guess" } }
    assert_refused
    assert @user.reload.authenticate("password123")
  end

  test "a new password with the current password is saved" do
    patch users_url, params: { user: { password: "new-password1", password_confirmation: "new-password1", current_password: "password123" } }
    assert_redirected_to users_url
    assert @user.reload.authenticate("new-password1")
  end

  test "a new email without the current password is refused, along with the other changes" do
    patch users_url, params: { user: { email_address: "thief@example.com", username: "renamed" } }
    assert_refused
    @user.reload
    assert_equal "one@example.com", @user.email_address
    assert_equal "userone", @user.username
  end

  test "a new email with the current password is saved" do
    patch users_url, params: { user: { email_address: "new@example.com", current_password: "password123" } }
    assert_redirected_to users_url
    assert_equal "new@example.com", @user.reload.email_address
  end

  test "resubmitting the same email in a different case needs no password" do
    patch users_url, params: { user: { email_address: " ONE@example.com ", username: "renamed", password: "", password_confirmation: "" } }
    assert_redirected_to users_url
    assert_equal "renamed", @user.reload.username
  end

  test "other profile changes need no password" do
    patch users_url, params: { user: { username: "renamed", timezone: "Asia/Tokyo" } }
    assert_redirected_to users_url
    assert_equal "renamed", @user.reload.username
  end

  test "JSON requests get the standard error body" do
    patch users_url(format: :json), params: { user: { email_address: "thief@example.com" } }
    assert_response :unprocessable_entity
    assert_equal I18n.t("users.update.current_password_incorrect"), response.parsed_body["details"]["current_password"].first
  end

  test "profile updates are rate-limited" do
    Rails.cache.stub(:increment, 1_000) do
      patch users_url, params: { user: { password: "new-password1", password_confirmation: "new-password1", current_password: "guess-guess" } }
    end
    assert_redirected_to edit_users_url
    assert_equal I18n.t("users.update.alert_rate_limit"), flash[:alert]
  end

  private
    def assert_refused
      assert_response :unprocessable_entity
      assert_select "#current_password_hint ~ p", text: I18n.t("users.update.current_password_incorrect")
      assert_select "input[name='user[current_password]'][aria-invalid=true]"
    end
end
