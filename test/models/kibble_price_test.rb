require "test_helper"

class KibblePriceTest < ActiveSupport::TestCase
  setup do
    @check = pets(:one).kibble_price_checks.create!(checked_on: Date.current)
  end

  def price(price_per_kg, **attrs)
    @check.kibble_prices.create!(brand: "曙光", description: "無穀滋養鴨肉食譜", source: "BigGo", product_title: "曙光 鴨肉 3磅",
                                 price_twd: 690, bag_size_label: "3磅", bag_size_kg: 1.361, price_per_kg: price_per_kg, **attrs)
  end

  test "ranked lists prices cheapest per kg first" do
    dear = price(663.3)
    cheap = price(507.0)

    assert_equal [ cheap, dear ], @check.kibble_prices.ranked.to_a
    assert_equal [ cheap, dear ], @check.prices_for("曙光", "無穀滋養鴨肉食譜").to_a
  end

  test "prices come from BigGo or PChome only" do
    assert price(507.0, source: "PChome").pchome?
    assert_raises(ActiveRecord::RecordInvalid) { price(507.0, source: "Gemini") }
  end

  test "one check per pet a day" do
    duplicate = pets(:one).kibble_price_checks.build(checked_on: Date.current)

    assert_not duplicate.valid?
    assert pets(:one).kibble_price_checks.build(checked_on: Date.tomorrow).valid?
  end

  test "a pet's checks go with it" do
    price(507.0)

    assert_difference -> { KibblePriceCheck.count } => -1, -> { KibblePrice.count } => -1 do
      pets(:one).destroy
    end
  end
end
