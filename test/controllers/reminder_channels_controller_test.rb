require "test_helper"

# Choosing how reminders come, on the profile page, and seeing why the last one
# was emailed instead.
class ReminderChannelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    log_in_as(@user)
  end

  test "the profile shows the choices, with the default picked, and LINE only for LINE users" do
    get users_path

    assert_response :success
    assert_select "#reminder-channel input[type=radio][value=android]"
    assert_select "#reminder-channel input[type=radio][value=email][checked]"
    assert_select "#reminder-channel input[type=radio][value=line]", count: 0

    @user.connected_services.create!(provider: "line", uid: "U123")
    get users_path
    assert_select "#reminder-channel input[type=radio][value=line][checked]"
  end

  test "choosing a channel saves it and clears an old problem" do
    @user.update!(reminder_problem: "android_failed", reminder_problem_at: 1.day.ago)

    patch reminder_channel_path, params: { reminder_channel: "email" }

    assert_redirected_to users_path(anchor: "reminder-channel")
    assert_equal "email", @user.reload.reminder_channel
    assert_nil @user.reminder_problem
    follow_redirect!
    assert_select "#reminder-channel input[type=radio][value=email][checked]"
  end

  test "LINE can't be chosen without LINE, nor anything unknown" do
    patch reminder_channel_path, params: { reminder_channel: "line" }
    assert_nil @user.reload.reminder_channel

    patch reminder_channel_path, params: { reminder_channel: "pigeon" }
    assert_nil @user.reload.reminder_channel
    assert_redirected_to users_path(anchor: "reminder-channel")
  end

  test "the profile says why the last reminder was emailed" do
    @user.update!(reminder_channel: "android", reminder_problem: "android_no_phone", reminder_problem_at: Time.current)

    get users_path

    assert_select "#reminder-channel [role=alert]", /No phone is signed in to the Pet Tracker Android app/
    assert_select "#reminder-channel", /No phone is signed in to the Android app yet/
  end

  test "needs sign-in" do
    delete session_path
    patch reminder_channel_path, params: { reminder_channel: "email" }

    assert_nil @user.reload.reminder_channel
  end
end
