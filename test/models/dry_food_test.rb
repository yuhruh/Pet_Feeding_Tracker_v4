require "test_helper"

class DryFoodTest < ActiveSupport::TestCase
  setup do
    @bag = dry_foods(:one)
    @bag.update_columns(amount: 1000)
    Tracker.where(dry_food: @bag).delete_all
  end

  def feed(date, time, amount, left_amount = nil)
    Tracker.create!(pet: pets(:one), dry_food: @bag, food_type: "kibble", brand: "brand", description: "kibble",
                    date: date, feed_time: @bag.household.time_zone.parse("#{date} #{time}"), amount: amount, left_amount: left_amount)
  end

  test "a top-up draws only what the cat ate since the last feeding" do
    feed("2026-10-21", "08:00", 20, 9.7)
    feed("2026-10-21", "20:00", 20)

    @bag.reload
    assert_equal 30.3, @bag.total_ate_amount
    assert_equal 969.7, @bag.left_amount
  end

  test "recording the newest leftover later keeps the bowl counted until the next feeding" do
    feed("2026-10-21", "08:00", 20, 9.7)
    evening = feed("2026-10-21", "20:00", 20)
    evening.update!(left_amount: 5)
    assert_equal 30.3, @bag.reload.total_ate_amount

    feed("2026-10-22", "08:00", 20)
    assert_equal 45.3, @bag.reload.total_ate_amount
  end

  test "a feeding whose leftover was thrown away counts in full" do
    morning = feed("2026-10-21", "08:00", 20, 9.7)
    feed("2026-10-21", "20:00", 20)
    morning.update!(leftover_discarded: true)

    assert_equal 40, @bag.reload.total_ate_amount
  end

  test "a wet feeding sent with a bag keeps no bag and draws nothing" do
    wet = nil
    assert_no_changes -> { @bag.reload.left_amount } do
      wet = Tracker.create!(pet: pets(:one), dry_food: @bag, food_type: "wet", brand: "brand", description: "tuna",
                            date: "2026-10-21", feed_time: @bag.household.time_zone.parse("2026-10-21 08:00"), amount: 40)
    end

    assert_nil wet.dry_food_id
  end

  test "switching a kibble feeding to another type gives its grams back to the bag" do
    feeding = feed("2026-10-21", "08:00", 20)
    assert_equal 20, @bag.reload.total_ate_amount

    feeding.update!(food_type: "other")
    assert_nil feeding.dry_food_id
    assert_equal 0, @bag.reload.total_ate_amount
  end

  test "a feeding without a recorded leftover counts in full" do
    feed("2026-10-21", "08:00", 20)
    feed("2026-10-21", "20:00", 20)

    assert_equal 40, @bag.reload.total_ate_amount
  end
end
