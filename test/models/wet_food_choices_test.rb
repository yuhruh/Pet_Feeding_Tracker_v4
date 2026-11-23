require "test_helper"

class WetFoodChoicesTest < ActiveSupport::TestCase
  setup do
    @pet = pets(:one)
    @sibling = Pet.create!(petname: "Mochi", household: @pet.household, gender: "♀️ Female", birthday: 2.years.ago, weight: 4)
    Tracker.where(pet: [ @pet, pets(:two) ]).delete_all
  end

  test "offers wet foods from every cat in the household, by brand, newest first" do
    feed(@pet, "Ciao", "Tuna & chicken", 3.days.ago)
    feed(@sibling, "Ciao", "Tuna & scallop", 1.day.ago)
    feed(@sibling, "Inaba", "Churu tuna", 2.days.ago)

    assert_equal({ "ciao" => [ "tuna & scallop", "tuna & chicken" ], "inaba" => [ "churu tuna" ] }, choices)
  end

  test "leaves out other households and other food types" do
    feed(pets(:two), "Weruva", "Mideast feast", 1.day.ago)
    feed(@pet, "Orijen", "Six fish", 1.day.ago, food_type: "Kibble")
    feed(@pet, "Ciao", "Tuna", 2.days.ago)

    assert_equal({ "ciao" => [ "tuna" ] }, choices)
  end

  # Trackers save brand and description lowercased; spaces and can counts still differ.
  test "counts spellings that differ only by spaces or a can count as one food" do
    feed(@pet, " ciao ", "tuna  x2", 1.day.ago)
    feed(@pet, "Ciao", "Tuna (×3)", 2.days.ago)
    feed(@pet, "CIAO", "Tuna", 3.days.ago)

    assert_equal({ "ciao" => [ "tuna" ] }, choices)
  end

  private

  def choices
    WetFoodChoices.new(@pet).by_brand
  end

  def feed(pet, brand, description, date, food_type: "Wet")
    pet.trackers.create!(date: date.to_date, feed_time: "08:00", food_type: food_type, brand: brand, description: description, amount: 50)
  end
end
