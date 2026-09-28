require "test_helper"
require "minitest/mock"

class KibblePrices::LookupTest < ActiveSupport::TestCase
  setup do
    @pet = pets(:one)
    @pet.trackers.destroy_all
    @pet.trackers.create!(date: Date.current, food_type: "Kibble", brand: "曙光", description: "無穀滋養鴨肉食譜",
                          hungry: "💖 Yes, eat right away", love: "💕", amount: 30, left_amount: 0, favorite_score: 45)
    @searched = []
    @asked_gemini = []
  end

  def listing(title, price, store: "momo購物網", variant: nil, url: "https://www.momoshop.com.tw/product/#{title.hash.abs}")
    KibblePrices::Listing.new(source: "BigGo", store: store, title: title, variant: variant, price_twd: price, url: url)
  end

  def gemini_offer(title, price, store: "毛孩市集")
    KibblePrices::Listing.new(source: "Gemini", store: store, title: title, variant: nil, price_twd: price,
                              url: "https://pet-shop.example/#{[ store, title ].hash.abs}")
  end

  # BigGo answers from listings_by_query; PChome finds nothing; Gemini offers gemini_offers.
  def lookup(listings_by_query, gemini_offers = [])
    big_go = ->(query) { @searched << query; listings_by_query.fetch(query, []) }
    gemini = ->(query, api_key:) { @asked_gemini << [ query, api_key ]; gemini_offers }
    KibblePrices::BigGoSearch.stub(:call, big_go) do
      KibblePrices::PchomeSearch.stub(:call, []) do
        KibblePrices::GeminiSearch.stub(:call, gemini) { KibblePrices::Lookup.new(@pet).call }
      end
    end
  end

  test "ranks matching listings by price per kg, cheapest first" do
    result = lookup("曙光 無穀滋養鴨肉食譜" => [
      listing("Spring Natural 曙光 無穀滋養鴨肉 全齡貓 3磅", 690, store: "PChome 24h購物"),
      listing("曙光貓無穀 滋養鴨肉食譜300克", 199, store: "Yahoo拍賣"),
      listing("曙光貓無穀 滋養鴨肉食譜 12磅", 2800, store: "蝦皮商城"),
      listing("Spring Natural 曙光 無穀滋養雞肉 全齡貓 3磅", 500)       # chicken, not duck
    ]).sole

    assert_equal [ 507.0, 514.4, 663.3 ], result[:prices].map { |row| row[:price_per_kg] }
    cheapest = result[:prices].first
    assert_equal [ "3磅", 1.361, 690 ], cheapest.values_at(:bag_size_label, :bag_size_kg, :price_twd)
    assert_equal({ protein: 1 }, result[:rejected])
    assert_equal [ "曙光 無穀滋養鴨肉食譜" ], result[:queries], "no brand-wide search once the exact name finds prices"
  end

  test "searches the brand when the exact name finds nothing" do
    # Nothing in "無穀滋養鴨肉食譜" says cat or dog, so the brand search is for any 飼料.
    result = lookup("曙光 飼料" => [ listing("曙光貓無穀 滋養鴨肉食譜300克", 199) ]).sole

    assert_equal [ "曙光 無穀滋養鴨肉食譜", "曙光 飼料" ], result[:queries]
    assert_equal 1, result[:prices].size
  end

  test "keeps the cheapest listing per shop and size, and drops listings it cannot price" do
    result = lookup("曙光 無穀滋養鴨肉食譜" => [
      listing("曙光貓無穀 滋養鴨肉食譜300克", 199, store: "Yahoo拍賣"),
      listing("曙光貓無穀 滋養鴨肉食譜300克 新包裝", 189, store: "Yahoo拍賣"),
      listing("曙光貓無穀 滋養鴨肉食譜 3磅/12磅", 690),                  # two sizes, one price
      listing("曙光貓無穀 滋養鴨肉食譜 10g", 30)                         # under NT$50: not a bag of kibble
    ]).sole

    assert_equal [ 189 ], result[:prices].map { |row| row[:price_twd] }
    assert_equal({ bag_size: 1, price: 1 }, result[:rejected])
  end

  test "lists at most eight prices" do
    listings = (1..10).map { |n| listing("曙光貓無穀 滋養鴨肉食譜 #{n}kg", 700 * n, store: "shop #{n}") }

    assert_equal 8, lookup("曙光 無穀滋養鴨肉食譜" => listings).sole[:prices].size
  end

  test "the pet's kibble names say which species to search for" do
    kibbles = [ { brand: "吶一口", description: "室內貓雙響宴" }, { brand: "曙光", description: "無穀滋養鴨肉食譜" } ]

    assert_equal :cat, KibblePrices::Lookup.species_of(kibbles)
    assert_equal :dog, KibblePrices::Lookup.species_of([ { brand: "柏萊富", description: "成犬 羊肉" } ])
    assert_nil KibblePrices::Lookup.species_of([ { brand: "曙光", description: "無穀滋養鴨肉食譜" } ])
  end

  test "asks Gemini, with the owner's key, only when BigGo and PChome find nothing" do
    @pet.user.update_columns(gemini_api_key: "owner-key")

    listed = lookup("曙光 無穀滋養鴨肉食譜" => [ listing("曙光貓無穀 滋養鴨肉食譜300克", 199) ]).sole
    assert_nil listed[:gemini]
    assert_empty @asked_gemini

    result = lookup({}, [ gemini_offer("Spring Natural 曙光 無穀滋養鴨肉 貓 3磅", 700) ]).sole
    assert_equal :used, result[:gemini]
    assert_equal [ [ "曙光 無穀滋養鴨肉食譜", "owner-key" ] ], @asked_gemini, "asked once, with the exact name"
    assert_equal [ [ "Gemini", 514.3 ] ], result[:prices].map { |row| row.values_at(:source, :price_per_kg) }
  end

  test "says so when Gemini would have helped but the owner has no key" do
    @pet.user.update_columns(gemini_api_key: nil)

    result = lookup({}).sole

    assert_equal :no_key, result[:gemini]
    assert_empty result[:prices]
    assert_empty @asked_gemini
  end

  test "Gemini's offers pass the same rules as listed ones" do
    @pet.user.update_columns(gemini_api_key: "owner-key")

    result = lookup({}, [ gemini_offer("Spring Natural 曙光 無穀滋養雞肉 貓 3磅", 600) ]).sole

    assert_empty result[:prices]
    assert_equal({ protein: 1 }, result[:rejected])
  end

  test "sets aside a Gemini price far from what the last check listed" do
    @pet.user.update_columns(gemini_api_key: "owner-key")
    earlier = @pet.kibble_price_checks.create!(checked_on: 1.month.ago.to_date, status: :done)
    [ 480.0, 507.0, 520.0 ].each do |per_kg|
      earlier.kibble_prices.create!(brand: "曙光", description: "無穀滋養鴨肉食譜", source: "BigGo", product_title: "曙光 鴨肉",
                                    price_twd: 690, bag_size_label: "3磅", bag_size_kg: 1.361, price_per_kg: per_kg)
    end

    result = lookup({}, [
      gemini_offer("曙光 無穀滋養鴨肉食譜 3磅", 700, store: "A"),   # NT$514/kg
      gemini_offer("曙光 無穀滋養鴨肉食譜 3磅", 150, store: "B")    # NT$110/kg: too good to be true
    ]).sole

    assert_equal [ [ "A", nil ], [ "B", "-78% from NT$507/kg" ] ], result[:prices].map { |row| row.values_at(:store, :suspicious_reason) }
    assert_equal [ false, true ], result[:prices].map { |row| row[:suspicious] || false }
  end

  test "without an earlier check, Gemini's own offers are the reference when there are enough" do
    @pet.user.update_columns(gemini_api_key: "owner-key")
    offers = ->(prices) { prices.each_with_index.map { |price, i| gemini_offer("曙光 無穀滋養鴨肉食譜 3磅", price, store: "shop #{i}") } }

    assert_equal [ "shop 3" ], lookup({}, offers.([ 700, 690, 720, 150 ])).sole[:prices].select { |row| row[:suspicious] }.map { |row| row[:store] }
    assert lookup({}, offers.([ 700, 150 ])).sole[:prices].none? { |row| row[:suspicious] }, "two offers are too few to judge"
  end
end
