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
    assert_select "##{dom_id(@fountain, :routines)} select[name$='[every]']", count: 3
    assert_select "select[name='routines[filter_changed][every]'] option[selected][value=off]"

    save_spot(cleaned: { every: "twice_a_week" }, filter_changed: { every: "custom", amount: "10", unit: "days" },
              refilled: { every: "set_times", times: [ "18:00", "08:00", "" ] })
    assert_equal "Saved.", flash[:notice]
    assert_equal({ "cleaned" => 96, "filter_changed" => 240, "refilled" => nil }, @fountain.care_routines.pluck(:action, :every_hours).to_h)
    assert_equal %w[08:00 18:00], @fountain.care_routines.find_by(action: "refilled").times

    get household_url(**L)
    assert_select "select[name='routines[cleaned][every]'] option[selected][value=twice_a_week]"
    assert_select "select[name='routines[filter_changed][every]'] option[selected][value=custom]"
    assert_select "input[name='routines[filter_changed][amount]'][value='10']"
    assert_select "select[name='routines[filter_changed][unit]'] option[selected][value=days]"
    assert_select "select[name='routines[refilled][every]'] option[selected][value=set_times]"
    assert_select "input[name='routines[refilled][times][]']", count: 4, message: "the two set times and two empty ones"
    assert_select "input[name='routines[refilled][times][]'][value='08:00']"

    save_spot(cleaned: { every: "custom", amount: "400", unit: "days" })
    assert_equal "Enter how many hours or days, up to 365 days.", flash[:alert]
    assert_equal 96, @fountain.care_routines.find_by(action: "cleaned").every_hours
  end

  test "caregivers can't change the intervals" do
    log_in_as(@mom)
    save_spot(cleaned: { every: "weekly" })
    assert_empty @fountain.care_routines
  end

  test "Today shows when each job is due, also on the viewer page" do
    @fountain.care_routines.create!(action: "cleaned", every_hours: 96, started_on: @today - 6)
    @fountain.care_routines.create!(action: "filter_changed", every_hours: 360, started_on: @today)
    @fountain.care_routines.create!(action: "refilled", every_hours: 24, started_on: @today - 1)

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

  # Checkpoint H2: several scoops a day.
  def box = @box ||= @household.care_spots.create!(kind: :litter_box, name: "Upstairs box")
  def at(hour, minute = 0, date: @today) = @zone.local(date.year, date.month, date.day, hour, minute)
  def scoop(time, by: @mom) = CareEvent.create!(kind: :litter, care_spot: box, actions: [ "scooped" ], actor: by, occurred_at: time)

  test "Today shows set times with their status, and how many times today" do
    box.care_routines.create!(action: "scooped", mode: "set_times", times: %w[00:30 23:59], started_on: @today)
    travel_to(at(12)) do
      scoop(at(0, 20))
      scoop(at(0, 40))
      log_in_as(@mom)
      get today_url(**L)
    end
    assert_select "##{dom_id(box)} .text-emerald-700", text: "00:30 ✓ 00:20 by Mom"
    assert_select "##{dom_id(box)} .text-gray-600", text: "23:59 due"
    assert_select "##{dom_id(box)}", text: /scooped 2× today/
  end

  test "a set time not done an hour after shows as not done" do
    box.care_routines.create!(action: "scooped", mode: "set_times", times: %w[08:00], started_on: @today)
    travel_to(at(9, 30)) do
      log_in_as(@mom)
      get today_url(**L)
    end
    assert_select "##{dom_id(box)} .text-red-600", text: "08:00 not done"
  end

  test "Today shows a due time for intervals under a day" do
    box.care_routines.create!(action: "scooped", every_hours: 8, started_on: @today)
    travel_to(at(12)) do
      scoop(at(9, 15))
      log_in_as(@mom)
      get today_url(**L)
      assert_select "##{dom_id(box)}", text: /🚽 Scooped due at 17:15/
    end
    travel_to(at(18)) do
      get today_url(**L)
      assert_select "##{dom_id(box)} .text-red-600", text: "🚽 Scooped overdue since 17:15"
    end
  end

  test "a second scoop half an hour later doesn't ask again; within 30 minutes it does" do
    log_in_as(@mom)
    post care_events_url(**L), params: { care_spot_id: box.id, care_action: "scooped" }
    travel 20.minutes do
      post care_events_url(**L), params: { care_spot_id: box.id, care_action: "scooped" }
      assert flash[:care_repeat], "asks within 30 minutes"
      follow_redirect!
    end
    travel 40.minutes do
      assert_difference -> { box.care_events.count } do
        post care_events_url(**L), params: { care_spot_id: box.id, care_action: "scooped" }
      end
      assert_nil flash[:care_repeat]
    end
  end
end
