require "test_helper"

# Reminder schedules (checkpoints H, H2): "every …" counts from the latest record
# of the job (to the minute under a day, by the day for whole days); "at set
# times" is done by a record in each set time's window.
class CareRoutineTest < ActiveSupport::TestCase
  setup do
    @household = households(:one)
    @zone = @household.time_zone
    @today = Time.current.in_time_zone(@zone).to_date
    @fountain = @household.care_spots.create!(kind: :water_fountain, name: "Kitchen fountain")
    @box = @household.care_spots.create!(kind: :litter_box, name: "Upstairs box")
    @owner = users(:one)
  end

  def record(*actions, at:, spot: @fountain)
    kind = spot.litter_box? ? :litter : :water
    CareEvent.create!(kind: kind, care_spot: spot, actions: actions, actor: @owner, occurred_at: at)
  end

  def local(date, hour, minute = 0) = @zone.local(date.year, date.month, date.day, hour, minute)

  test "every whole days, never done: due that many days after it was set" do
    routine = @fountain.care_routines.create!(action: "cleaned", every_hours: 96, started_on: @today - 10)
    assert_not routine.hourly?
    assert_equal @today - 6, routine.due_on
  end

  test "every whole days: from the latest record of that job only, and doing it early moves the date" do
    routine = @fountain.care_routines.create!(action: "cleaned", every_hours: 96, started_on: @today - 30)
    record("refilled", "cleaned", at: 3.days.ago)
    record("refilled", at: 1.hour.ago)
    assert_equal (3.days.ago.in_time_zone(@zone).to_date + 4), routine.due_on, "a refill doesn't count as cleaning"

    record("cleaned", at: 1.day.ago)
    assert_equal (1.day.ago.in_time_zone(@zone).to_date + 4), routine.due_on

    record("cleaned", at: 30.minutes.ago).undo!
    assert_equal (1.day.ago.in_time_zone(@zone).to_date + 4), routine.due_on, "an undone tap doesn't count"
  end

  test "every under a day: due to the minute after the last time it was done" do
    routine = @box.care_routines.create!(action: "scooped", every_hours: 12, started_on: @today)
    assert routine.hourly?
    assert_in_delta routine.created_at + 12.hours, routine.due_at, 1, "never done: from when it was set"

    scooped = record("scooped", at: 3.hours.ago, spot: @box)
    assert_in_delta scooped.occurred_at + 12.hours, routine.due_at, 1
    record("full_change", at: 1.hour.ago, spot: @box)
    assert_in_delta scooped.occurred_at + 12.hours, routine.due_at, 1, "another job doesn't count"

    assert @box.care_routines.new(action: "full_change", every_hours: 36, started_on: @today).hourly?, "not whole days: to the minute"
  end

  test "set times: a record counts for the set time it's closest after, up to 2 hours late" do
    routine = @box.care_routines.create!(action: "scooped", mode: "set_times", times: %w[20:00 08:00], started_on: @today)
    assert_equal %w[08:00 20:00], routine.times, "tidied in order"
    yesterday = @today - 1
    record("scooped", at: local(yesterday, 8, 30), spot: @box)    # late for 08:00
    record("scooped", at: local(yesterday, 19, 40), spot: @box)   # early for 20:00
    record("scooped", at: local(yesterday, 22, 30), spot: @box)   # after 20:00's late window: early for tomorrow's 08:00

    slots = routine.slots(yesterday)
    assert_equal %w[08:00 20:00], slots.map(&:time)
    assert_equal [ local(yesterday, 8, 30), local(yesterday, 19, 40) ], slots.map { |slot| slot.event&.occurred_at }
    assert_equal local(@today, 8), routine.slots(@today).first.at
    assert routine.slots(@today).first.done?, "22:30 the night before counts for 08:00"

    one_slot = routine.slots(@today).last
    assert_not one_slot.done?
    assert_equal "due", one_slot.status(local(@today, 19, 59))
    assert_equal "due", one_slot.status(local(@today, 20, 30))
    assert_equal "late", one_slot.status(local(@today, 21, 1))
  end

  test "set times close together split the gap" do
    routine = @box.care_routines.create!(action: "scooped", mode: "set_times", times: %w[08:00 09:00], started_on: @today)
    slot = routine.slots(@today).first
    assert_equal local(@today, 8, 30), slot.to, "half the gap, not 2 hours"
  end

  test "set times are checked" do
    assert_not @box.care_routines.new(action: "scooped", mode: "set_times", times: [], started_on: @today).valid?
    assert_not @box.care_routines.new(action: "scooped", mode: "set_times", times: %w[25:00], started_on: @today).valid?
    assert_not @box.care_routines.new(action: "scooped", mode: "set_times", times: %w[01:00 02:00 03:00 04:00 05:00 06:00 07:00], started_on: @today).valid?
    assert @box.care_routines.new(action: "scooped", mode: "set_times", times: [ "08:00", "", "08:00" ], started_on: @today).tap(&:valid?).times == [ "08:00" ]
  end

  test "the household page's choices: presets in hours, custom hours or days, set times, off" do
    failed = CareRoutine.apply(@fountain, { "cleaned" => { "every" => "twice_a_week" }, "filter_changed" => { "every" => "custom", "amount" => "10", "unit" => "days" },
                                            "refilled" => { "every" => "twice_a_day" } }, today: @today)
    assert_empty failed
    assert_equal({ "cleaned" => 96, "filter_changed" => 240, "refilled" => 12 }, @fountain.care_routines.pluck(:action, :every_hours).to_h)
    assert_equal [ @today ], @fountain.care_routines.distinct.pluck(:started_on)
    assert_equal %w[twice_a_week custom twice_a_day], @fountain.care_routines.order(:action).map(&:preset)
    assert_equal [ 10, "days" ], @fountain.care_routines.find_by(action: "filter_changed").custom_amount

    CareRoutine.apply(@fountain, { "cleaned" => { "every" => "custom", "amount" => "36", "unit" => "hours" } }, today: @today + 5)
    cleaned = @fountain.care_routines.find_by(action: "cleaned")
    assert_equal 36, cleaned.every_hours
    assert_equal [ 36, "hours" ], cleaned.custom_amount
    assert_equal @today, cleaned.started_on, "a changed interval keeps the day it was first set"

    CareRoutine.apply(@fountain, { "cleaned" => { "every" => "set_times", "times" => [ "18:00", "08:00", "" ] } }, today: @today)
    cleaned.reload
    assert cleaned.mode_set_times?
    assert_equal %w[08:00 18:00], cleaned.times
    assert_nil cleaned.every_hours
    assert_equal "set_times", cleaned.preset

    CareRoutine.apply(@fountain, { "cleaned" => { "every" => "daily" } }, today: @today)
    assert_equal [ "every", 24, [] ], cleaned.reload.then { |r| [ r.mode, r.every_hours, r.times ] }

    CareRoutine.apply(@fountain, { "cleaned" => { "every" => "off" } }, today: @today)
    assert_not @fountain.care_routines.exists?(action: "cleaned")

    failed = CareRoutine.apply(@fountain, { "cleaned" => { "every" => "custom", "amount" => "0", "unit" => "hours" },
                                            "refilled" => { "every" => "set_times", "times" => [ "" ] } }, today: @today)
    assert_equal %w[refilled cleaned], failed.map(&:action), "in the spot's order"
    assert_not @fountain.care_routines.exists?(action: "cleaned")
    assert_equal 12, @fountain.care_routines.find_by(action: "refilled").reload.every_hours, "a bad change leaves it as it was"
  end

  test "a fountain turned into a bowl loses its filter reminder" do
    CareRoutine.apply(@fountain, { "filter_changed" => { "every" => "monthly" }, "cleaned" => { "every" => "weekly" } }, today: @today)
    @fountain.update!(kind: :water_bowl)
    CareRoutine.apply(@fountain, {}, today: @today)
    assert_equal [ "cleaned" ], @fountain.care_routines.pluck(:action)
    assert_not @fountain.care_routines.new(action: "filter_changed", every_hours: 168, started_on: @today).valid?
  end
end
