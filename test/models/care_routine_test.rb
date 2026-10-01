require "test_helper"

# Reminder intervals (checkpoint H): due = the latest record of the job + the
# interval, or the day it was set + the interval.
class CareRoutineTest < ActiveSupport::TestCase
  setup do
    @household = households(:one)
    @zone = @household.time_zone
    @today = Time.current.in_time_zone(@zone).to_date
    @fountain = @household.care_spots.create!(kind: :water_fountain, name: "Kitchen fountain")
    @owner = users(:one)
  end

  def record(*actions, at:)
    CareEvent.create!(kind: :water, care_spot: @fountain, actions: actions, actor: @owner, occurred_at: at)
  end

  test "never done: due the interval after the day it was set" do
    routine = @fountain.care_routines.create!(action: "cleaned", every_days: 4, started_on: @today - 10)
    assert_equal @today - 6, routine.due_on
  end

  test "due counts from the latest record of that job only, and doing it early moves the date" do
    routine = @fountain.care_routines.create!(action: "cleaned", every_days: 4, started_on: @today - 30)
    record("refilled", "cleaned", at: 3.days.ago)
    record("refilled", at: 1.hour.ago)
    assert_equal (3.days.ago.in_time_zone(@zone).to_date + 4), routine.due_on, "a refill doesn't count as cleaning"

    record("cleaned", at: 1.day.ago)
    assert_equal (1.day.ago.in_time_zone(@zone).to_date + 4), routine.due_on

    record("cleaned", at: 30.minutes.ago).undo!
    assert_equal (1.day.ago.in_time_zone(@zone).to_date + 4), routine.due_on, "an undone tap doesn't count"
  end

  test "the household page's choices: presets, custom, off, and the spot's own jobs only" do
    failed = CareRoutine.apply(@fountain, { "cleaned" => { "every" => "twice_a_week" }, "filter_changed" => { "every" => "custom", "days" => "10" },
                                            "refilled" => { "every" => "off" } }, today: @today)
    assert_empty failed
    assert_equal({ "cleaned" => 4, "filter_changed" => 10 }, @fountain.care_routines.order(:action).pluck(:action, :every_days).to_h)
    assert_equal [ @today ], @fountain.care_routines.distinct.pluck(:started_on)
    assert_equal "twice_a_week", @fountain.care_routines.find_by(action: "cleaned").preset
    assert_equal "custom", @fountain.care_routines.find_by(action: "filter_changed").preset

    CareRoutine.apply(@fountain, { "cleaned" => { "every" => "monthly" } }, today: @today + 5)
    cleaned = @fountain.care_routines.find_by(action: "cleaned")
    assert_equal 30, cleaned.every_days
    assert_equal @today, cleaned.started_on, "a changed interval keeps the day it was first set"

    CareRoutine.apply(@fountain, { "cleaned" => { "every" => "off" } }, today: @today)
    assert_not @fountain.care_routines.exists?(action: "cleaned")

    failed = CareRoutine.apply(@fountain, { "cleaned" => { "every" => "custom", "days" => "0" } }, today: @today)
    assert_equal [ "cleaned" ], failed.map(&:action)
    assert_not @fountain.care_routines.exists?(action: "cleaned")
  end

  test "a fountain turned into a bowl loses its filter interval" do
    CareRoutine.apply(@fountain, { "filter_changed" => { "every" => "monthly" }, "cleaned" => { "every" => "weekly" } }, today: @today)
    @fountain.update!(kind: :water_bowl)
    CareRoutine.apply(@fountain, {}, today: @today)
    assert_equal [ "cleaned" ], @fountain.care_routines.pluck(:action)
    assert_not @fountain.care_routines.new(action: "filter_changed", every_days: 7, started_on: @today).valid?
  end
end
