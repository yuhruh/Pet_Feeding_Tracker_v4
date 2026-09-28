require "test_helper"

# Titles and variants below are real BigGo listings (2026-09-28).
class KibblePrices::MatcherTest < ActiveSupport::TestCase
  def matcher(brand, description, species: :cat, brand_names: nil)
    KibblePrices::Matcher.new({ brand: brand, description: description, dry_food: nil }, species: species, brand_names: brand_names)
  end

  test "matches despite different wording and a variant character" do
    neko = matcher("吶一口", "室內貓雙響宴")

    assert neko.match?(title: "Neko 吶一口 凍乾貓飼料", variant: "室內雙饗宴(新鮮雞肉/火雞肉 + 雞肉/虱目魚凍乾) 150g 2包")
    assert_equal :variant, neko.rejection(title: "吶一口 凍乾貓飼料/無穀鮮肉貓飼料 原野收穫/豐收漁獲/田園雙饗宴/室內雙饗宴/海洋雙饗宴", variant: "(原野收穫),1.36KG")
    assert_equal :coverage, neko.rejection(title: "吶一口 無穀鮮肉糧 吶一口貓飼料 吶一口凍乾糧", variant: "凍乾糧-田園雙嚮宴1kg")
  end

  test "every protein the owner named must be in the listing" do
    duck = matcher("曙光", "無穀滋養鴨肉食譜")

    assert duck.match?(title: "☆汪喵小舖2店☆ 美國 Spring Natural 曙光貓無穀 滋養鴨肉食譜300克 // 貓飼料")
    assert_equal :protein, duck.rejection(title: "Spring Natural 曙光 無穀滋養雞肉 全齡貓 天然寵物食譜 貓飼料")
    assert_equal :protein, duck.rejection(title: "Spring Natural 曙光 無穀滋養火雞肉 全齡貓 天然寵物食譜 貓飼料")
    assert_equal :protein, matcher("天然密碼", "無穀鴨肉&火雞肉 全齡貓配方")
      .rejection(title: "天然密碼貓飼料 天然密碼無穀 雞肉 鮭魚 火雞肉", variant: "無穀鮭魚、鯡魚和曼哈頓魚 1.11kg")
  end

  test "judges a multi-flavor listing by the variant it priced" do
    duck = matcher("璞斯", "體態管理全齡貓 鴨肉")

    assert duck.match?(title: "PURPOSE 璞斯 無穀營養配方全齡貓糧 雞肉口味 鴨肉口味 貓飼料", variant: "鴨肉｜體態管理配方﹣2kg")
    assert_equal :variant, duck.rejection(title: "PURPOSE 璞斯 無穀營養配方全齡貓糧 無穀體態管理配方 雞肉 鴨肉 貓糧", variant: "無穀營養配方全齡貓糧 雞肉口味")
    assert matcher("璞斯", "無穀營養雞肉配方").match?(title: "璞斯PURPOSE 2kg/4.5kg 無穀營養配方全齡貓糧 貓飼料", variant: "雞肉配方 2KG (超商限2包)")
  end

  test "product-line codes must agree" do
    indoor = matcher("皇家", "室內成貓 IN27")

    assert indoor.match?(title: "【ROYAL 法國皇家】室內成貓專用飼料 IN27 4KG(貓乾糧)")
    assert_equal :code, indoor.rejection(title: "法國皇家ROYAL CANIN 【IN+7室內熟齡貓】保健成貓專用飼料1.5kg")
    assert_equal :variant, indoor.rejection(title: "法國皇家 ROYAL CANIN 貓飼料 成貓 室內貓 IN27", variant: "L40 體重控制成貓-1.5kg")
  end

  test "the brand may appear under any of its names" do
    purrsuit = matcher("喵皇奴 purrsuit", "鮮雞肉")

    assert purrsuit.match?(title: "Purrsuit 無穀鮮雞肉 貓飼料 2kg"), "the English name alone"
    assert purrsuit.match?(title: "喵皇奴 無穀鮮雞肉 貓飼料 2kg"), "the Chinese name alone"
    assert matcher("超躍", "無穀雞肉", brand_names: Set["超躍", "hyperr"]).match?(title: "Hyperr 無穀雞肉 貓飼料")
    assert_equal :brand, matcher("go", "雞肉").rejection(title: "GoGo貓 雞肉 貓飼料"), "a Latin name is a whole word"
  end

  test "brand, species and short-dated stock" do
    duck = matcher("曙光", "無穀滋養鴨肉食譜")

    assert_equal :brand, duck.rejection(title: "天然密碼 無穀滋養鴨肉 貓飼料")
    assert_equal :species, duck.rejection(title: "美國 Spring Natural 曙光犬無穀 滋養鴨肉食譜300克 // 狗飼料")
    assert matcher("曙光", "無穀滋養鴨肉食譜", species: nil).match?(title: "曙光犬無穀 滋養鴨肉食譜300克 // 狗飼料")
    assert_equal :reject_word, matcher("璞斯", "無穀營養雞肉配方").rejection(title: "效期2025/11 璞斯 PURPOSE 無穀營養配方全齡貓糧 雞肉", variant: "雞肉2kg")
  end
end
