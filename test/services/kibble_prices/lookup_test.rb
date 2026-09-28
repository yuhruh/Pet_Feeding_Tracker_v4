require "test_helper"
require "minitest/mock"

class KibblePrices::LookupTest < ActiveSupport::TestCase
  setup do
    @pet = pets(:one)
    @pet.trackers.destroy_all
    @pet.trackers.create!(date: Date.current, food_type: "Kibble", brand: "曙光", description: "無穀滋養鴨肉食譜",
                          hungry: "💖 Yes, eat right away", love: "💕", amount: 30, left_amount: 0, favorite_score: 45)
    @searched = []
  end

  def listing(title, price, store: "momo購物網", variant: nil, url: "https://www.momoshop.com.tw/product/#{title.hash.abs}")
    KibblePrices::Listing.new(source: "BigGo", store: store, title: title, variant: variant, price_twd: price, url: url)
  end

  # BigGo answers from listings_by_query; PChome finds nothing.
  def lookup(listings_by_query)
    big_go = ->(query) { @searched << query; listings_by_query.fetch(query, []) }
    KibblePrices::BigGoSearch.stub(:call, big_go) do
      KibblePrices::PchomeSearch.stub(:call, []) { KibblePrices::Lookup.new(@pet).call }
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
end
