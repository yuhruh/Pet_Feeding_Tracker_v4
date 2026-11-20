require "test_helper"

# Sign-up doesn't prove the email address, so someone else can open an account
# with your address and link their own Google, LINE or GitHub to it. Resetting
# the password (which the emailed link proves is you) must leave them outside.
class PasswordResetLinkedSignInsTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @user.connected_services.delete_all # the fixture's placeholder
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(provider: "github", uid: "someone-else", info: { email: "someone@else.example", name: "Someone" })
  end

  teardown do
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:github] = nil
  end

  def reset_password
    patch password_url(token: @user.password_reset_token), params: { password: "brandnewpass1", password_confirmation: "brandnewpass1" }
    assert_redirected_to new_session_url
  end

  test "a reset disconnects linked sign-in methods and says so" do
    @user.connected_services.create!(provider: "github", uid: "someone-else")
    @user.connected_services.create!(provider: "line", uid: "U-someone-else")

    reset_password
    assert_empty @user.connected_services.reload
    assert_equal I18n.t("passwords.update.notice_disconnected", providers: [ "GitHub", "LINE" ].to_sentence), flash[:notice]
  end

  test "after a reset the provider that was linked no longer signs in to the account" do
    @user.connected_services.create!(provider: "github", uid: "someone-else")
    reset_password

    outsider = open_session
    outsider.post "/auth/github?timezone=Asia/Taipei"
    outsider.follow_redirect! # the callback
    assert_empty @user.sessions.reload, "not signed in to the reset account"
    assert_equal "someone@else.example", ConnectedService.find_by!(provider: "github", uid: "someone-else").user.email_address, "a separate account of their own"
  end

  test "a provider sign-in on its way to the Android app is dropped by a reset" do
    code_digest = NativeSignIn.digest(NativeSignIn.issue!(user: @user, path: "/", challenge: "c"))
    reset_password
    assert_not NativeSignIn.exists?(token_digest: code_digest)
  end

  test "a reset with nothing linked keeps the plain message" do
    reset_password
    assert_equal I18n.t("passwords.update.notice"), flash[:notice]
  end

  test "a failed reset disconnects nothing" do
    @user.connected_services.create!(provider: "github", uid: "someone-else")
    patch password_url(token: @user.password_reset_token), params: { password: "brandnewpass1", password_confirmation: "different-one" }
    assert_equal 1, @user.connected_services.count
  end
end
