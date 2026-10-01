require "test_helper"

class MedsOnTodayTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    @zone = @household.time_zone
    @pet = pets(:one)
    @pet.update!(petname: "Aji")
    @mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @mom, role: :caregiver)
    @clavamox = @pet.medications.create!(name: "Clavamox", dose: "1 tablet", times: %w[08:00 20:00], starts_on: Date.new(2026, 9, 1))
    log_in_as(@mom)
  end

  def at(hour, minute = 0) = @zone.local(2026, 10, 1, hour, minute)
  def give(**params) = post(care_events_url(**L), params: { pet_id: @pet.id, kind: "meds", medication_id: @clavamox.id, dose_status: "given", **params })
  def card = "##{ActionView::RecordIdentifier.dom_id(@pet, :care)}"

  test "the cat's line shows each dose: overdue, due, then given" do
    travel_to at(19, 50) do
      get today_url(**L)
      assert_select card, text: /Clavamox 1 tablet: 08:00 overdue · 20:00 due/
      assert_select "##{ActionView::RecordIdentifier.dom_id(@pet, :meds)}", text: /Give Aji Clavamox 1 tablet \(20:00 dose\)\?.*Give Aji Clavamox 1 tablet \(08:00 dose\)\?/m,
                    message: "the dose closest to now first"

      give(dose_time: "20:00")
      event = CareEvent.meds.sole
      assert_equal [ @clavamox, "20:00", "given", @mom ], [ event.medication, event.dose_time, event.dose_status, event.actor ]
      follow_redirect!
      assert_select "#care_notice", text: /Aji: Clavamox 1 tablet \(20:00\), given/
      assert_select card, text: /20:00 given by Mom at 19:50/
      assert_select "ol li", text: /💊 Aji: Clavamox 1 tablet \(20:00\), given · Mom/
    end
  end

  test "couldn't give, with a reason" do
    travel_to at(8, 15) do
      give(dose_time: "08:00", dose_status: "couldnt_give", reason: "spat_out")
      assert_equal [ "couldnt_give", "spat_out" ], CareEvent.meds.sole.values_at(:dose_status, :reason)
      get today_url(**L)
      assert_select card, text: /08:00 couldn't give \(spat it out\)/
    end
  end

  test "a dose already given asks before a second one" do
    travel_to at(19, 55) do
      give(dose_time: "20:00")
    end
    travel_to at(20, 10) do
      log_in_as(@owner)
      give(dose_time: "20:00")
      assert_equal 1, CareEvent.meds.count
      follow_redirect!
      assert_select "#care_repeat", text: /Mom already gave Aji Clavamox 1 tablet \(20:00\) at 19:55\. Record it again\?/

      give(dose_time: "20:00", confirmed: 1)
      assert_equal 2, CareEvent.meds.count
    end
  end

  test "no 💊 for a caregiver on a cat without medications; the owner can record a one-off medicine" do
    @clavamox.update!(stopped_at: Time.current)
    get today_url(**L)
    assert_select "##{ActionView::RecordIdentifier.dom_id(@pet, :meds)}", count: 0
    post care_events_url(**L), params: { pet_id: @pet.id, kind: "meds", dose_status: "given", medicine_name: "Cerenia" }
    assert_equal I18n.t("care_events.not_allowed"), flash[:alert]

    log_in_as(@owner)
    get today_url(**L)
    assert_select "##{ActionView::RecordIdentifier.dom_id(@pet, :meds)}", text: /Other medicine/
    post care_events_url(**L), params: { pet_id: @pet.id, kind: "meds", dose_status: "given", medicine_name: "Cerenia", medicine_dose: "0.5 tab" }
    assert_equal({ "medicine_name" => "Cerenia", "medicine_dose" => "0.5 tab" }, CareEvent.meds.sole.details)
  end

  test "as-needed medications show their last dose" do
    gaba = @pet.medications.create!(name: "Gabapentin", dose: "50 mg")
    get today_url(**L)
    assert_select card, text: /Gabapentin 50 mg: as needed, none given yet/
    post care_events_url(**L), params: { pet_id: @pet.id, kind: "meds", medication_id: gaba.id, dose_status: "given" }
    get today_url(**L)
    assert_select card, text: /Gabapentin 50 mg: as needed, last given \d\d:\d\d by Mom/
  end

  test "another cat's or a stopped medication, and a wrong dose time, are refused" do
    other = pets(:two).medications.create!(name: "Other", times: [ "08:00" ])
    give(medication_id: other.id)
    assert_equal I18n.t("care_events.not_found"), flash[:alert]

    give(dose_time: "12:00")
    assert_equal I18n.t("activerecord.errors.models.care_event.attributes.dose_time.inclusion"), flash[:alert]

    @clavamox.update!(stopped_at: Time.current)
    give(dose_time: "08:00")
    assert_equal I18n.t("care_events.not_found"), flash[:alert]
    assert_empty CareEvent.all
  end

  test "a dose's outcome and reason can be changed on its page; viewers see statuses but no 💊" do
    give(dose_time: "08:00", confirmed: 1)
    event = CareEvent.meds.sole
    get edit_care_event_url(event, **L)
    assert_select "input[type=radio][name=dose_status][value=couldnt_give]"
    patch care_event_url(event, **L), params: { dose_status: "couldnt_give", reason: "vomited" }
    assert_equal [ "couldnt_give", "vomited" ], event.reload.values_at(:dose_status, :reason)

    link = @household.viewer_links.create!(name: "Grandma", created_by: @owner)
    delete session_url(**L)
    get viewer_page_url(token: link.token, **L)
    assert_select "#today_status", text: /Clavamox 1 tablet: 08:00 couldn't give \(vomited\)/
    assert_select "##{ActionView::RecordIdentifier.dom_id(@pet, :meds)}", count: 0
  end
end
