require "test_helper"

# Pins down the favorite-food list, so moving its logic into Pet cannot change it.
class FavoriteFoodTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as(users(:one))
    @pet = pets(:one)
    @pet.trackers.destroy_all

    # Six days of the same kibble; the list keeps the five best-scored days.
    (1..6).each do |day|
      feed(date: "2026-09-0#{day}", food_type: "Kibble", brand: "Royal Canin", description: "Indoor 27", favorite_score: 25 + day * 5)
    end
    # A trailing count joins the same food, and a second feeding on one day counts once.
    feed(date: "2026-09-06", food_type: "Kibble", brand: "Royal Canin", description: "Indoor 27 x2", favorite_score: 20)
    # Full-width brackets around the count are handled too.
    feed(date: "2026-09-01", food_type: "Wet", brand: "Ciao", description: "Tuna（x3）", favorite_score: 60)
    # Feedings with neither a hungry nor a love rating are left out.
    feed(date: "2026-09-02", food_type: "Wet", brand: "Inaba", description: "Chicken", favorite_score: 90, hungry: nil, love: "")
  end

  test "groups foods, keeps each food's five best days, most loved first" do
    get favorite_food_pet_trackers_url(@pet, format: :json)
    assert_response :success

    foods = response.parsed_body
    assert_equal [ [ "wet", "ciao", "tuna" ], [ "kibble", "royal canin", "indoor 27" ] ],
                 foods.map { |f| f.values_at("food_type", "brand", "description") }

    kibble = foods.second
    assert_equal 7, kibble["count"]
    assert_equal %w[2026/09/06 2026/09/05 2026/09/04 2026/09/03 2026/09/02], kibble["results"].map { |r| r["date"] }
    assert_equal [ 55, 50, 45, 40, 35 ], kibble["results"].map { |r| r["favorite_score"] }
    assert_equal %w[id date result favorite_score], kibble["results"].first.keys
  end

  test "filters by food type" do
    get favorite_food_pet_trackers_url(@pet, format: :json, food_type: "Kibble")

    assert_equal [ "royal canin" ], response.parsed_body.map { |f| f["brand"] }
  end

  test "renders the page" do
    get favorite_food_pet_trackers_url(@pet)

    assert_response :success
    assert_match "royal canin", response.body
  end

  private

  def feed(hungry: "💖 Yes, eat right away", love: "💕", **attrs)
    @pet.trackers.create!(hungry: hungry, love: love, amount: 50, left_amount: 0, **attrs)
  end
end
