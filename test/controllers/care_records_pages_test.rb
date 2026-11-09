require "test_helper"

# The owner's care records page: any past day, filtered by cat or spot and type,
# with Change and Delete on every record of any age, coming back to the same day
# afterwards. Owner only.
class CareRecordsPagesTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    @zone = @household.time_zone
    @pet = pets(:one)
    @pet.update!(petname: "aji")
    @mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @mom, role: :caregiver)
    @box = @household.care_spots.create!(kind: :litter_box, name: "Upstairs box")
    @today = Time.current.in_time_zone(@zone).to_date
    @day = @today - 5
    @fed = record(kind: :fed, pet: @pet, at: noon(@day))
    @scooped = record(kind: :litter, care_spot: @box, actions: [ "scooped" ], at: noon(@day) + 2.hours)
    @old = record(kind: :weight, pet: @pet, value: 4.2, at: noon(@today - 10))
  end

  def noon(date) = @zone.local(date.year, date.month, date.day, 12)

  def record(at:, **attributes)
    CareEvent.create!(actor: @mom, occurred_at: at, created_at: at, **attributes)
  end

  def page(**params) = household_care_records_url(**L, **params)

  test "the household page links to it, and it opens on today" do
    log_in_as(@owner)
    get household_url(**L)
    assert_select "#care_records a[href='#{household_care_records_path(**L)}']"

    get page
    assert_response :success
    assert_select "input[type=date][value='#{@today.iso8601}'][max='#{@today.iso8601}']"
    assert_select "#next-day", count: 0
    assert_select "#care-records-day", text: /No records on this day/
  end

  test "a past day shows its records, with Change and Delete coming back to that day" do
    log_in_as(@owner)
    get page(date: @day.iso8601)

    assert_select "##{dom_id(@fed)}", text: /Aji: fed/
    assert_select "##{dom_id(@scooped)}"
    assert_select "##{dom_id(@fed)} a[href='#{edit_care_event_path(@fed, **L, return_date: @day.iso8601)}']"
    assert_select "##{dom_id(@fed)} form input[name=return_date][value='#{@day.iso8601}']"
    assert_select "#next-day[href*='date=#{(@day + 1).iso8601}']"

    get edit_care_event_url(@fed, **L, return_date: @day.iso8601)
    assert_select "input[type=hidden][name=return_date][value='#{@day.iso8601}']"
    assert_select "a[href='#{household_care_records_path(**L, date: @day.iso8601)}']", text: "Back to care records"

    patch care_event_url(@fed, **L), params: { return_date: @day.iso8601, note: "half a bowl" }
    assert_redirected_to household_care_records_url(**L, date: @day.iso8601)
    assert_equal "half a bowl", @fed.reload.note

    delete care_event_url(@scooped, **L), params: { return_date: @day.iso8601 }
    assert_redirected_to household_care_records_url(**L, date: @day.iso8601)
    assert @scooped.reload.undone?
  end

  test "the owner changes and deletes records of any age, and moves a time any day back" do
    log_in_as(@owner)
    get page(date: (@today - 10).iso8601)
    assert_select "##{dom_id(@old)} a", text: "Change"
    assert_select "##{dom_id(@old)} input[name=_method][value=delete]"

    get edit_care_event_url(@old, **L, return_date: (@today - 10).iso8601)
    assert_select "input[name=occurred_at]:not([min])", message: "no earliest time for the owner"

    patch care_event_url(@old, **L), params: { return_date: (@today - 10).iso8601, value: "4.4" }
    assert_redirected_to household_care_records_url(**L, date: (@today - 10).iso8601)
    assert_nil flash[:alert]
    assert_equal 4.4, @old.reload.value.to_f

    months_ago = noon(@today - 60)
    patch care_event_url(@old, **L), params: { occurred_at: months_ago.strftime("%Y-%m-%dT%H:%M") }
    assert_nil flash[:alert]
    assert_equal months_ago, @old.reload.occurred_at

    patch care_event_url(@old, **L), params: { occurred_at: 1.day.from_now.in_time_zone(@zone).strftime("%Y-%m-%dT%H:%M") }
    assert_equal I18n.t("activerecord.errors.models.care_event.attributes.occurred_at.in_the_future"), flash[:alert]

    delete care_event_url(@old, **L), params: { return_date: (@today - 10).iso8601 }
    assert @old.reload.undone?
  end

  test "caregivers keep their limits: an earliest time on the details page, and no moving a record more than 7 days back" do
    mine = record(kind: :fed, pet: @pet, at: 1.hour.ago)
    log_in_as(@mom)
    get edit_care_event_url(mine, **L)
    assert_select "input[name=occurred_at][min]"

    patch care_event_url(mine, **L), params: { occurred_at: 9.days.ago.in_time_zone(@zone).strftime("%Y-%m-%dT%H:%M") }
    assert_equal I18n.t("activerecord.errors.models.care_event.attributes.occurred_at.too_long_ago"), flash[:alert]
  end

  test "filters by cat or spot and by type" do
    log_in_as(@owner)
    get page(date: @day.iso8601, subject: "spot-#{@box.id}")
    assert_select "##{dom_id(@scooped)}"
    assert_select "##{dom_id(@fed)}", count: 0

    get page(date: @day.iso8601, kind: "fed")
    assert_select "##{dom_id(@fed)}"
    assert_select "##{dom_id(@scooped)}", count: 0
    assert_select "#previous-day[href*='kind=fed']"
  end

  test "the chosen type and cat or spot stay chosen after Delete, Change and Back" do
    log_in_as(@owner)
    get page(date: @day.iso8601, kind: "litter", subject: "spot-#{@box.id}")
    back = { return_date: @day.iso8601, return_kind: "litter", return_subject: "spot-#{@box.id}" }
    filtered = household_care_records_url(**L, date: @day.iso8601, kind: "litter", subject: "spot-#{@box.id}")
    assert_select "##{dom_id(@scooped)} form input[name=return_kind][value=litter]"
    assert_select "##{dom_id(@scooped)} form input[name=return_subject][value='spot-#{@box.id}']"

    get edit_care_event_url(@scooped, **L, **back)
    assert_select "input[type=hidden][name=return_kind][value=litter]"
    assert_select "a[href='#{household_care_records_path(**L, date: @day.iso8601, kind: 'litter', subject: "spot-#{@box.id}")}']",
                  text: "Back to care records"

    patch care_event_url(@scooped, **L), params: back.merge(note: "clumpy")
    assert_redirected_to filtered

    delete care_event_url(@scooped, **L), params: back
    assert_redirected_to filtered
    follow_redirect!
    assert_select "select[name=kind] option[selected][value=litter]"
    assert_select "select[name=subject] option[selected][value='spot-#{@box.id}']"
  end

  test "made-up filter values are dropped on the way back" do
    log_in_as(@owner)
    delete care_event_url(@fed, **L), params: { return_date: @day.iso8601, return_kind: "naps", return_subject: "x-1; drop" }
    assert_redirected_to household_care_records_url(**L, date: @day.iso8601)
  end

  test "a future or broken date shows today" do
    log_in_as(@owner)
    get page(date: (@today + 3).iso8601)
    assert_select "input[type=date][value='#{@today.iso8601}']"

    get page(date: "soon")
    assert_select "input[type=date][value='#{@today.iso8601}']"
  end

  test "without a return day, changes still go back to Today" do
    log_in_as(@owner)
    patch care_event_url(@fed, **L), params: { note: "x" }
    assert_redirected_to today_url(**L)

    patch care_event_url(@fed, **L), params: { note: "y", return_date: "nope" }
    assert_redirected_to today_url(**L)
  end

  test "caregivers can't open it" do
    log_in_as(@mom)
    get page(date: @day.iso8601)

    assert_response :redirect
    assert_no_match "Aji: fed", response.body
  end
end
