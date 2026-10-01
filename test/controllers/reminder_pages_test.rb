require "test_helper"

# Checkpoint H pages: the owner's reminder intervals on the household page, the
# due lines on Today, and each person's reminders switch.
class ReminderPagesTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    @zone = @household.time_zone
    @today = Time.current.in_time_zone(@zone).to_date
    @mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @mom, role: :caregiver)
    @grandma = User.create!(username: "grandma", email_address: "grandma@example.com", email_address_confirmation: "grandma@example.com",
                            password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @grandma, role: :viewer)
    @fountain = @household.care_spots.create!(kind: :water_fountain, name: "Kitchen fountain")
  end

  def save_spot(**routines)
    patch household_care_spot_url(@fountain, **L), params: { care_spot: { name: "Kitchen fountain", kind: "water_fountain" }, routines: routines }
  end

  test "the owner sets how often each job is due, with the spot's name" do
    log_in_as(@owner)
    get household_url(**L)
    assert_select "##{dom_id(@fountain, :routines)} select", count: 3
    assert_select "select[name='routines[filter_changed][every]'] option[selected][value=off]"

    save_spot(cleaned: { every: "twice_a_week" }, filter_changed: { every: "custom", days: "10" }, refilled: { every: "off" })
    assert_equal "Saved.", flash[:notice]
    assert_equal({ "cleaned" => 4, "filter_changed" => 10 }, @fountain.care_routines.pluck(:action, :every_days).to_h)

    get household_url(**L)
    assert_select "select[name='routines[cleaned][every]'] option[selected][value=twice_a_week]"
    assert_select "select[name='routines[filter_changed][every]'] option[selected][value=custom]"
    assert_select "input[name='routines[filter_changed][days]'][value='10']"

    save_spot(cleaned: { every: "custom", days: "400" })
    assert_equal "Enter how many days, from 1 to 365.", flash[:alert]
    assert_equal 4, @fountain.care_routines.find_by(action: "cleaned").every_days
  end

  test "caregivers can't change the intervals" do
    log_in_as(@mom)
    save_spot(cleaned: { every: "weekly" })
    assert_empty @fountain.care_routines
  end

  test "Today shows when each job is due, also on the viewer page" do
    @fountain.care_routines.create!(action: "cleaned", every_days: 4, started_on: @today - 6)
    @fountain.care_routines.create!(action: "filter_changed", every_days: 15, started_on: @today)
    @fountain.care_routines.create!(action: "refilled", every_days: 1, started_on: @today - 1)

    log_in_as(@mom)
    get today_url(**L)
    assert_select "##{dom_id(@fountain)} .text-red-600", text: "🧽 Fountain cleaned 2 days overdue"
    assert_select "##{dom_id(@fountain)}", text: /🔄 Filter changed due in 15 days/
    assert_select "##{dom_id(@fountain)} .text-amber-700", text: "💧 Refilled due today"

    link = @household.viewer_links.create!(name: "Grandma", created_by: @owner)
    get viewer_page_url(token: link.token, **L)
    assert_select "##{dom_id(@fountain)}", text: /Fountain cleaned 2 days overdue/
  end

  test "the owner and caregivers turn their own reminders on and off; viewers can't" do
    log_in_as(@owner)
    get today_url(**L)
    assert_select "##{dom_id(@household, :reminders)}", text: /Reminders: off/
    patch household_reminders_url(@household, **L), params: { enabled: true }
    assert @household.reload.owner_reminders_enabled?
    assert_not @household.memberships.find_by(user: @mom).reminders_enabled?
    follow_redirect!
    assert_select "##{dom_id(@household, :reminders)}", text: /Reminders by email: on/

    delete session_url(**L)
    @mom.connected_services.create!(provider: "line", uid: "U1")
    log_in_as(@mom)
    patch household_reminders_url(@household, **L), params: { enabled: true }
    assert @household.memberships.find_by(user: @mom).reminders_enabled?
    follow_redirect!
    assert_select "##{dom_id(@household, :reminders)}", text: /Reminders by LINE: on/
    patch household_reminders_url(@household, **L), params: { enabled: false }
    assert_not @household.memberships.find_by(user: @mom).reminders_enabled?
    assert @household.reload.owner_reminders_enabled?, "only their own"

    delete session_url(**L)
    log_in_as(@grandma)
    get today_url(**L)
    assert_select "##{dom_id(@household, :reminders)}", count: 0
    patch household_reminders_url(@household, **L), params: { enabled: true }
    assert_equal I18n.t("care_events.not_allowed"), flash[:alert]
    assert_not @household.memberships.find_by(user: @grandma).reminders_enabled?
  end

  test "someone outside the household can't turn its reminders on" do
    log_in_as(users(:two))
    patch household_reminders_url(@household, **L), params: { enabled: true }
    assert_equal I18n.t("care_events.not_allowed"), flash[:alert]
    assert_not @household.reload.owner_reminders_enabled?
  end
end
