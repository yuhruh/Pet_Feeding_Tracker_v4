require "test_helper"

# Every form that sets a password shows the minimum length up front, enforces
# it, and never reports success when the password was not actually changed.
class PasswordPolicyTest < ActionDispatch::IntegrationTest
  SHORT = "1234567".freeze     # one character under User::MINIMUM_PASSWORD_LENGTH
  LONG_ENOUGH = "12345678".freeze

  # --- sign-up ---

  test "sign-up shows the minimum length before submitting" do
    get new_registrations_url(locale: I18n.default_locale)
    assert_password_hint I18n.t("registrations.new.password_hint", count: User::MINIMUM_PASSWORD_LENGTH)
  end

  test "sign-up rejects a short password" do
    assert_no_difference("User.count") do
      post registrations_url(locale: I18n.default_locale), params: { user: sign_up_params(SHORT) }
    end
    assert_response :unprocessable_entity
    assert_includes response.body, too_short_message
  end

  test "sign-up accepts an 8-character password" do
    assert_difference("User.count") do
      post registrations_url(locale: I18n.default_locale), params: { user: sign_up_params(LONG_ENOUGH) }
    end
  end

  # --- profile edit ---

  test "profile edit shows the minimum length and that blank keeps the current password" do
    log_in_as(users(:one))
    get edit_users_url
    assert_password_hint I18n.t("users.edit.password_hint", count: User::MINIMUM_PASSWORD_LENGTH)
  end

  test "profile edit rejects a short password and keeps the old one" do
    user = users(:one)
    log_in_as(user)
    patch users_url, params: { user: { password: SHORT, password_confirmation: SHORT, current_password: "password123" } }
    assert_response :unprocessable_entity
    assert_includes response.body, too_short_message
    assert user.reload.authenticate("password123")
  end

  test "profile edit with blank password fields saves other changes and keeps the current password" do
    user = users(:one)
    log_in_as(user)
    patch users_url, params: { user: { username: "renamed", password: "", password_confirmation: "" } }
    assert_redirected_to users_path
    assert_equal "renamed", user.reload.username
    assert user.authenticate("password123")
  end

  test "profile edit rejects a new password typed only in the confirmation box" do
    user = users(:one)
    log_in_as(user)
    patch users_url, params: { user: { password: "", password_confirmation: LONG_ENOUGH, current_password: "password123" } }
    assert_response :unprocessable_entity
    assert_select "p", text: blank_message
    assert user.reload.authenticate("password123")
  end

  # --- password reset ---

  test "password reset shows the minimum length before submitting" do
    get edit_password_url(token: users(:one).password_reset_token, locale: I18n.default_locale)
    assert_password_hint I18n.t("passwords.edit.password_hint", count: User::MINIMUM_PASSWORD_LENGTH)
  end

  test "password reset rejects a short password and says why" do
    user = users(:one)
    token = user.password_reset_token
    patch password_url(token: token, locale: I18n.default_locale), params: { password: SHORT, password_confirmation: SHORT }
    assert_redirected_to edit_password_url(token: token, locale: I18n.default_locale)
    assert_equal too_short_message, flash[:alert]
    assert user.reload.authenticate("password123")
  end

  test "password reset with empty fields is rejected instead of reporting success" do
    user = users(:one)
    token = user.password_reset_token
    patch password_url(token: token, locale: I18n.default_locale), params: { password: "", password_confirmation: "" }
    assert_redirected_to edit_password_url(token: token, locale: I18n.default_locale)
    assert_equal blank_message, flash[:alert]
    assert user.reload.authenticate("password123")
  end

  test "password reset accepts an 8-character password" do
    user = users(:one)
    patch password_url(token: user.password_reset_token, locale: I18n.default_locale), params: { password: LONG_ENOUGH, password_confirmation: LONG_ENOUGH }
    assert_redirected_to new_session_url(locale: I18n.default_locale)
    assert user.reload.authenticate(LONG_ENOUGH)
  end

  private
    def sign_up_params(password)
      { username: "newbie", email_address: "newbie@example.com", email_address_confirmation: "newbie@example.com",
        password: password, password_confirmation: password, timezone: "Asia/Taipei" }
    end

    # The hint is visible, and the password field enforces the length and points screen readers at the hint.
    def assert_password_hint(text)
      assert_response :success
      assert_select "#password_hint", text: text
      assert_select "input[type=password][minlength='#{User::MINIMUM_PASSWORD_LENGTH}'][aria-describedby=password_hint]", count: 1
    end

    def too_short_message
      User.new.errors.full_message(:password, I18n.t("errors.messages.too_short", count: User::MINIMUM_PASSWORD_LENGTH))
    end

    def blank_message
      User.new.errors.full_message(:password, I18n.t("errors.messages.blank"))
    end
end
