require "test_helper"

class KibblePrices::QueryTest < ActiveSupport::TestCase
  test "searches the exact name first, then the brand" do
    kibble = { brand: "天然密碼", description: "無穀鴨肉&火雞肉 全齡貓配方", dry_food: nil }

    assert_equal [ "天然密碼 無穀鴨肉 火雞肉 全齡貓配方", "天然密碼 貓飼料" ], KibblePrices::Query.for(kibble, species: :cat)
    assert_equal "天然密碼 飼料", KibblePrices::Query.for(kibble).last
  end

  test "prefers the bag's name and drops a trailing count" do
    bag = DryFood.new(brand: "Royal Canin", description: "室內成貓 IN27（x2）")
    kibble = { brand: "皇家", description: "室內", dry_food: bag }

    assert_equal "Royal Canin 室內成貓 IN27", KibblePrices::Query.for(kibble).first
  end
end
