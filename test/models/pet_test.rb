require "test_helper"

class PetTest < ActiveSupport::TestCase
  setup do
    @pet = pets(:one)
    @pet.trackers.destroy_all
    @bag = dry_foods(:one)
  end

  test "favorite_kibbles lists only kibble, most loved first" do
    feed(food_type: "Kibble", brand: "Royal Canin", description: "Indoor 27", favorite_score: 40)
    feed(food_type: "Kibble", brand: "Orijen", description: "Six Fish", favorite_score: 50)
    feed(food_type: "Wet", brand: "Ciao", description: "Tuna", favorite_score: 60)
    feed(food_type: "Freeze-Dried", brand: "Absolute", description: "Chicken", favorite_score: 70)

    assert_equal [ "orijen", "royal canin" ], @pet.favorite_kibbles.map { |f| f[:brand] }
  end

  test "favorite_kibbles leaves out low scores, old feedings and anything past the limit" do
    feed(food_type: "Kibble", brand: "Low", description: "Score", favorite_score: 29)
    feed(food_type: "Kibble", brand: "Old", description: "Feeding", favorite_score: 60, date: 5.months.ago.to_date)
    feed(food_type: "Kibble", brand: "Recent", description: "Feeding", favorite_score: 31, date: (3.months.ago - 2.weeks).to_date)
    (1..6).each { |n| feed(food_type: "Kibble", brand: "Brand #{n}", description: "Kibble", favorite_score: 30 + n) }

    assert_equal (2..6).map { |n| "brand #{n}" }.reverse, @pet.favorite_kibbles.map { |f| f[:brand] }
    assert_includes @pet.favorite_kibbles(limit: 10).map { |f| f[:brand] }, "recent", "fed three and a half months ago is within the four-month window"
    assert_equal [ "old" ], @pet.favorite_kibbles(min_score: 60, since: 6.months.ago).map { |f| f[:brand] }
    assert_equal 2, @pet.favorite_kibbles(limit: 2).size
  end

  test "favorite_kibbles links the bag the kibble was last fed from" do
    feed(food_type: "Kibble", brand: "Royal Canin", description: "Indoor 27", favorite_score: 40, date: 2.days.ago.to_date, dry_food: @bag)
    feed(food_type: "Kibble", brand: "Royal Canin", description: "Indoor 27", favorite_score: 45, date: 1.day.ago.to_date)
    feed(food_type: "Kibble", brand: "Orijen", description: "Six Fish", favorite_score: 35)

    kibbles = @pet.favorite_kibbles.index_by { |f| f[:brand] }
    assert_equal @bag, kibbles["royal canin"][:dry_food]
    assert_nil kibbles["orijen"][:dry_food]
  end

  private

  def feed(date: Date.current, **attrs)
    @pet.trackers.create!(date: date, hungry: "💖 Yes, eat right away", love: "💕", amount: 1, left_amount: 0, **attrs)
  end
end
