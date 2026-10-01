require "test_helper"

class MedicationTest < ActiveSupport::TestCase
  setup do
    @pet = pets(:one)
    @household = households(:one)
    @owner = users(:one)
    @zone = @household.time_zone
    @med = @pet.medications.create!(name: "Clavamox", dose: "1 tablet", times: [ "20:00", "08:00", "" ])
  end

  def dose(**attributes)
    CareEvent.new({ kind: :meds, pet: @pet, actor: @owner, occurred_at: Time.current, medication: @med, dose_status: "given" }.merge(attributes))
  end

  test "times are tidied and checked; dates in order" do
    assert_equal %w[08:00 20:00], @med.times
    assert_equal Date.current, @med.starts_on
    assert_not @pet.medications.new(name: "x", times: [ "25:00" ]).valid?
    assert_not @pet.medications.new(name: "x", times: %w[01:00 02:00 03:00 04:00 05:00]).valid?
    assert_not @pet.medications.new(name: "x", starts_on: Date.current, ends_on: Date.yesterday).valid?
    assert @pet.medications.create!(name: "Gabapentin").as_needed?
  end

  test "active on a day: started, not ended, not stopped" do
    assert @med.active_on?(Date.current)
    assert_not @med.active_on?(Date.yesterday)
    @med.update!(ends_on: Date.current + 3)
    assert_not @med.active_on?(Date.current + 4)
    @med.update!(stopped_at: Time.current)
    assert_not @med.active_on?(Date.current)
  end

  test "each dose today is due, given, couldn't give or overdue" do
    travel_to @zone.local(2026, 10, 1, 20, 45) do
      date = Date.new(2026, 10, 1)
      @med.update!(starts_on: date)
      morning, evening = @med.doses_on(date, @zone, [])
      assert_equal %w[overdue due], [ morning.status, evening.status ], "08:00 is overdue at 20:45; 20:00 is within the hour"

      given = dose(dose_time: "20:00", occurred_at: @zone.local(2026, 10, 1, 20, 5)).tap(&:save!)
      missed = dose(dose_time: "08:00", dose_status: "couldnt_give", reason: "spat_out", occurred_at: @zone.local(2026, 10, 1, 8, 10)).tap(&:save!)
      morning, evening = @med.doses_on(date, @zone, [ given, missed ])
      assert_equal %w[couldnt_give given], [ morning.status, evening.status ]
    end
  end

  test "a dose record is checked: status, reason, dose time, and the cat's own medication" do
    assert dose(dose_time: "08:00").valid?
    assert_not dose(dose_status: "maybe").valid?
    assert_not dose(dose_status: "couldnt_give").valid?, "needs a reason"
    assert dose(dose_status: "couldnt_give", reason: "vomited").valid?
    assert_nil dose(reason: "vomited").tap(&:valid?).reason, "no reason when given"
    assert_not dose(dose_time: "12:00").valid?, "not one of its times"

    other_cats = pets(:two).medications.create!(name: "Other")
    assert_not dose(medication: other_cats).valid?
    assert_not CareEvent.new(kind: :fed, pet: @pet, actor: @owner, occurred_at: Time.current, medication: @med).valid?
  end

  test "a one-off medicine needs a name" do
    assert_not dose(medication: nil).valid?
    assert dose(medication: nil, details: { medicine_name: "Cerenia", medicine_dose: "0.5 tab" }).valid?
    assert_not dose(medication: nil, dose_time: "08:00", details: { medicine_name: "x" }).valid?
  end

  test "double doses: the same scheduled dose given today, or an as-needed dose within 2 hours" do
    dose(dose_time: "08:00", occurred_at: 1.minute.ago).save!
    assert dose(dose_time: "08:00").recent_dose
    assert_nil dose(dose_time: "20:00").recent_dose
    assert_nil dose(dose_time: "08:00", dose_status: "couldnt_give", reason: "refused").recent_dose, "a missed dose never blocks"

    as_needed = @pet.medications.create!(name: "Gabapentin")
    dose(medication: as_needed, occurred_at: 90.minutes.ago).save!
    assert dose(medication: as_needed).recent_dose
    assert_nil dose(medication: as_needed, occurred_at: 1.minute.from_now).tap { |d| d.occurred_at += 1.hour }.recent_dose

    dose(medication: nil, details: { medicine_name: "Cerenia" }, occurred_at: 10.minutes.ago).save!
    assert dose(medication: nil, details: { medicine_name: "Cerenia" }).recent_dose
    assert_nil dose(medication: nil, details: { medicine_name: "Other pill" }).recent_dose
  end

  test "a medication with doses can't be deleted, only stopped; deleting the cat removes both" do
    dose(dose_time: "08:00").save!
    assert_not @med.destroy
    assert_difference -> { Medication.count }, -1 do
      @pet.destroy!
    end
  end
end
