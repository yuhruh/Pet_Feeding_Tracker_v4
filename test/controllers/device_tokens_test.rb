require "test_helper"

# The Android app's notification token (checkpoint I): registered for the
# signed-in person and session, handed over when someone else signs in on the
# phone, removed on request and when signing out.
class DeviceTokensTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @other = users(:two)
  end

  def register(token = "phone-1") = post(device_token_url(**L), params: { token: token, platform: "android" }, as: :json)

  test "registers the phone for the signed-in person and session, once" do
    log_in_as(@owner)
    register
    assert_response :no_content
    token = DeviceToken.sole
    assert_equal [ @owner, "android" ], [ token.user, token.platform ]
    assert_equal @owner.sessions.last, token.session
    assert_not_nil token.last_used_at

    assert_no_difference(-> { DeviceToken.count }) { register }
  end

  test "someone else signing in on the phone takes the token over" do
    log_in_as(@owner)
    register
    delete session_url(**L)
    assert_empty DeviceToken.all, "signing out removes the session's tokens"

    log_in_as(@owner)
    register
    log_in_as(@other)
    register
    assert_equal @other, DeviceToken.sole.user
  end

  test "removes only the person's own token" do
    DeviceToken.register(user: @other, session: nil, token: "their-phone")
    log_in_as(@owner)
    register
    delete device_token_url(**L), params: { token: "their-phone" }, as: :json
    delete device_token_url(**L), params: { token: "phone-1" }, as: :json
    assert_response :no_content
    assert_equal [ "their-phone" ], DeviceToken.pluck(:token)
  end

  test "needs a sign-in, and a token" do
    register
    assert_empty DeviceToken.all
    log_in_as(@owner)
    post device_token_url(**L), params: { token: "" }, as: :json
    assert_response :bad_request
  end

  test "an expired session's tokens go with it" do
    log_in_as(@owner)
    register
    Session.where(id: DeviceToken.sole.session_id).update_all(last_active_at: 40.days.ago)
    Session.expired.delete_all
    assert_empty DeviceToken.all
  end
end
