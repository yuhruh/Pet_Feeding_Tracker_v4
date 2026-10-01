require "test_helper"
require "turbo/broadcastable/test_helper"

# Delete a mistaken record (checkpoint H3): the owner any record, a caregiver
# their own for 24 hours; the record is hidden everywhere, with who deleted it.
class DeleteCareRecordsTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper
  include ActionCable::TestHelper
  include Turbo::Broadcastable::TestHelper

  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    @zone = @household.time_zone
    @pet = pets(:one)
    @pet.update!(petname: "aji")
    @mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @dad = User.create!(username: "dad", email_address: "dad@example.com", email_address_confirmation: "dad@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @grandma = User.create!(username: "grandma", email_address: "grandma@example.com", email_address_confirmation: "grandma@example.com",
                            password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @mom, role: :caregiver)
    @household.memberships.create!(user: @dad, role: :caregiver)
    @household.memberships.create!(user: @grandma, role: :viewer)
    @fed = CareEvent.create!(kind: :fed, pet: @pet, actor: @mom, occurred_at: 20.minutes.ago)
  end

  def row = "##{dom_id(@fed)}"

  test "a caregiver deletes their own mistaken feeding; it's gone from Today and the status, and who deleted it is kept" do
    log_in_as(@mom)
    get today_url(**L)
    assert_select "#{row} form[action='#{care_event_path(@fed)}'] input[name=_method][value=delete]"
    assert_select "#{row} form[data-turbo-confirm*='Delete “Aji: fed” at']"

    delete care_event_url(@fed, **L)
    assert_redirected_to today_url(**L)
    assert_match(/\ADeleted\. Aji: fed at \d\d:\d\d\z/, flash[:notice])
    @fed.reload
    assert @fed.undone?
    assert_equal @mom, @fed.deleted_by

    follow_redirect!
    assert_select row, count: 0
    assert_select "#today_status, ##{dom_id(@pet, :care)}", text: /Not fed yet today/
  end

  test "the owner deletes anyone's record; a caregiver not another's or an older one; viewers and outsiders never" do
    log_in_as(@dad)
    get today_url(**L)
    assert_select "#{row} input[name=_method][value=delete]", count: 0
    delete care_event_url(@fed, **L)
    assert_equal I18n.t("care_events.not_allowed"), flash[:alert]
    assert_not @fed.reload.undone?

    delete session_url(**L)
    log_in_as(@grandma)
    get today_url(**L)
    assert_select "#{row} input[name=_method][value=delete]", count: 0
    delete care_event_url(@fed, **L)
    assert_not @fed.reload.undone?

    delete session_url(**L)
    log_in_as(users(:two))
    delete care_event_url(@fed, **L)
    assert_equal I18n.t("care_events.not_found"), flash[:alert]
    assert_not @fed.reload.undone?

    old = CareEvent.create!(kind: :fed, pet: @pet, actor: @mom, occurred_at: 2.days.ago)
    old.update_columns(created_at: 2.days.ago)
    delete session_url(**L)
    log_in_as(@mom)
    delete care_event_url(old, **L)
    assert_not old.reload.undone?, "a caregiver's own record only for 24 hours"

    delete session_url(**L)
    log_in_as(@owner)
    delete care_event_url(@fed, **L)
    assert_equal @owner, @fed.reload.deleted_by
    delete care_event_url(old, **L)
    assert old.reload.undone?
  end

  test "a deleted record leaves the charts, the CSV, doses and reminder due dates" do
    medication = @pet.medications.create!(name: "Clavamox", dose: "1 tablet", times: [ 30.minutes.ago.in_time_zone(@zone).strftime("%H:%M") ], starts_on: 1.day.ago.to_date)
    dose = CareEvent.create!(kind: :meds, pet: @pet, medication: medication, dose_time: medication.times.first, dose_status: "given", actor: @mom, occurred_at: 10.minutes.ago)
    box = @household.care_spots.create!(kind: :litter_box, name: "Upstairs box")
    routine = box.care_routines.create!(action: "scooped", every_hours: 48, started_on: 5.days.ago.to_date)
    scooped = CareEvent.create!(kind: :litter, care_spot: box, actions: [ "scooped" ], actor: @mom, occurred_at: 1.hour.ago)
    weight = CareEvent.create!(kind: :weight, pet: @pet, value: 4.4, actor: @mom, occurred_at: 5.minutes.ago)
    due_after_scoop = routine.due_on

    log_in_as(@owner)
    [ @fed, dose, scooped, weight ].each { |event| delete care_event_url(event, **L) }

    chart = CareChart.new(@pet)
    assert chart.counts.values.all?(&:empty?), "nothing left on Care by day"
    assert_empty chart.weights
    assert_not HouseholdDay.new(@household).doses(@pet).sole.recorded?
    assert_operator routine.due_on, :<, due_after_scoop, "the deleted scoop no longer counts"

    get household_care_records_url(format: :csv, **L)
    assert_equal 1, CSV.parse(response.body, col_sep: ";").size, "only the header"
  end

  test "deleting a feeding added to trackers keeps the tracker, which then shows on the timeline" do
    tracker = Time.use_zone(@zone) do
      @pet.trackers.create!(date: Date.current, feed_time: 20.minutes.ago.strftime("%H:%M"), food_type: "Wet", brand: "Ciao", description: "Tuna", amount: 40)
    end
    @fed.update!(tracker: tracker)
    log_in_as(@owner)
    get today_url(**L)
    assert_select "#{row} form[data-turbo-confirm*='tracker stays']"
    assert_no_match(/\(tracker\)/, css_select("#today_status, section").text)

    delete care_event_url(@fed, **L)
    assert_includes flash[:notice], "The tracker added from it stays."
    assert Tracker.exists?(tracker.id)
    assert_nil @fed.reload.tracker_id
    follow_redirect!
    assert_select "li", text: /ciao tuna · 40 g\s*\(tracker\)/
  end

  test "the details page has Delete too, and other pages hear about it" do
    log_in_as(@mom)
    get edit_care_event_url(@fed, **L)
    assert_select "form[action='#{care_event_path(@fed)}'] input[name=_method][value=delete]"

    assert_turbo_stream_broadcasts(@household) { perform_enqueued_jobs { delete care_event_url(@fed, **L) } }
  end

  test "an undone or deleted record can't be deleted again" do
    @fed.delete_by!(@mom)
    log_in_as(@owner)
    delete care_event_url(@fed, **L)
    assert_equal I18n.t("care_events.not_found"), flash[:alert]
    assert_equal @mom, @fed.reload.deleted_by
  end
end
