require "test_helper"

# Sessions end after a period without use and a fixed time after sign-in, can be
# ended on other devices, and end everywhere else when the password changes.
class SessionExpiryTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # password "password123"
  end

  test "a session is kept while in use and records activity at most once an hour" do
    log_in_as @user
    session_record = @user.sessions.last

    travel 10.minutes do
      assert_no_changes -> { session_record.reload.last_active_at } do
        get users_url
      end
      assert_response :success
    end

    travel 2.hours do
      assert_changes -> { session_record.reload.last_active_at } do
        get users_url
      end
    end
  end

  test "a session idle for longer than the idle timeout is ended" do
    log_in_as @user
    session_record = @user.sessions.last

    travel Session::IDLE_TIMEOUT + 1.minute do
      get users_url
      assert_redirected_to new_session_url
      assert_not Session.exists?(session_record.id)
      assert cookies[:session_id].blank?
    end
  end

  test "a session is ended after the absolute timeout even when used every day" do
    log_in_as @user
    session_record = @user.sessions.last

    (1..(Session::ABSOLUTE_TIMEOUT.in_days.to_i / 20)).each do |step|
      travel_to session_record.created_at + (20 * step).days do
        get users_url
        assert_response :success
      end
    end

    # The browser drops the cookie when it expires, so also check the server refuses
    # a cookie that is still sent (e.g. a device clock that is behind).
    session_record.update_columns(created_at: (Session::ABSOLUTE_TIMEOUT + 1.minute).ago, last_active_at: Time.current)
    get users_url
    assert_redirected_to new_session_url
    assert_not Session.exists?(session_record.id)
  end

  test "the session cookie expires with the session" do
    post session_url, params: { email_address: @user.email_address, password: "password123" }
    set_cookie = Array(response.headers["Set-Cookie"]).join("\n")
    expires = set_cookie[/session_id=[^\n]*?expires=([^;\n]+)/i, 1]
    assert expires, "session cookie has no expiry"
    assert_in_delta Session::ABSOLUTE_TIMEOUT.from_now.to_i, Time.httpdate(expires).to_i, 60
  end

  test "the expired scope finds idle and too-old sessions only" do
    fresh = @user.sessions.create!
    idle = @user.sessions.create!(last_active_at: (Session::IDLE_TIMEOUT + 1.day).ago)
    old = @user.sessions.create!(created_at: (Session::ABSOLUTE_TIMEOUT + 1.day).ago)

    assert_equal [ idle, old ].sort, Session.expired.to_a.sort
    assert_not fresh.expired?
    Session.expired.delete_all
    assert Session.exists?(fresh.id)
  end

  test "signing out other devices keeps this one" do
    other = @user.sessions.create!
    someone_else = users(:two).sessions.create!
    log_in_as @user
    this_one = @user.sessions.order(:created_at).last

    get users_url
    assert_includes response.body, I18n.t("users.show.other_sessions", count: 1)

    delete other_sessions_url
    assert_redirected_to users_url
    assert_not Session.exists?(other.id)
    assert Session.exists?(this_one.id)
    assert Session.exists?(someone_else.id)

    follow_redirect!
    assert_response :success
    assert_includes response.body, I18n.t("users.show.other_sessions", count: 0)
  end

  test "changing the password on the profile signs out other devices" do
    other = @user.sessions.create!
    log_in_as @user

    patch users_url, params: { user: { password: "new-password1", password_confirmation: "new-password1", current_password: "password123" } }
    assert_not Session.exists?(other.id)
    get users_url
    assert_response :success
  end

  test "a profile update without a new password keeps other devices signed in" do
    other = @user.sessions.create!
    log_in_as @user

    patch users_url, params: { user: { username: "renamed" } }
    assert Session.exists?(other.id)
  end

  test "resetting the password signs out every device" do
    other = @user.sessions.create!

    put password_url(token: @user.password_reset_token), params: { password: "new-password1", password_confirmation: "new-password1" }
    assert_redirected_to new_session_url
    assert_not Session.exists?(other.id)
  end
end
