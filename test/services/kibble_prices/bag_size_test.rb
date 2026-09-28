require "test_helper"

class KibblePrices::BagSizeTest < ActiveSupport::TestCase
  def assert_size(kg, label, text)
    assert_equal({ kg: kg, label: label }, KibblePrices::BagSize.parse(text), text)
  end

  test "reads kg, g, 公斤, 克 and lb" do
    assert_size 2.0, "2kg", "Royal Canin法國皇家 IN27室內成貓飼料 2kg"
    assert_size 2.0, "2公斤", "IN27 室內成貓專用飼料2公斤"
    assert_size 0.3, "300克", "曙光貓無穀 滋養鴨肉食譜300克 // 貓飼料"
    assert_size 1.11, "1.11kg", "無穀鮭魚、鯡魚和曼哈頓魚 1.11kg"
    assert_size 1.497, "3.3lb", "3.3lb"
    assert_size 4.0, "4kg", "４ｋｇ"
  end

  test "multiplies pack counts and keeps the shop's wording as the label" do
    assert_size 4.0, "2kg 2包組", "Royal Canin法國皇家 IN27室內成貓飼料 2kg 2包組"
    assert_size 0.3, "150g 2包", "室內雙饗宴(新鮮雞肉/火雞肉 + 雞肉/虱目魚凍乾) 150g 2包"
    assert_size 4.0, "2kg x 2", "2kg x 2"
    assert_size 4.0, "2kg*2", "2kg*2"
    assert_size 1.5, "500g分裝【3包】", "12/10號-放養雞500g分裝【3包】"
    assert_size 4.0, "4kg", "4kg 1個 雞"
  end

  test "a shipping limit is not a pack count" do
    assert_size 2.0, "2kg", "2kg (超取最多2件)"
    assert_size 2.0, "2KG", "雞肉配方 2KG (超商限2包)"
  end

  test "nil when there is no size or several sizes for one price" do
    assert_nil KibblePrices::BagSize.parse("Indoor 27")
    assert_nil KibblePrices::BagSize.parse("IN27 4KG/10KG")
    assert_nil KibblePrices::BagSize.parse("1.5kg /3.5kg複")
    assert_nil KibblePrices::BagSize.parse(nil)
  end
end
