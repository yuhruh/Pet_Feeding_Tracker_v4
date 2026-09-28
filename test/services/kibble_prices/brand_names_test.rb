require "test_helper"

class KibblePrices::BrandNamesTest < ActiveSupport::TestCase
  test "splits a brand into its Chinese and Latin names" do
    assert_equal Set["喵皇奴", "purrsuit"], KibblePrices::BrandNames.split("喵皇奴 purrsuit")
    assert_equal Set["mon petit", "貓倍麗"], KibblePrices::BrandNames.split("Mon Petit 貓倍麗")
    assert_equal Set["summit10", "森咪特"], KibblePrices::BrandNames.split("summit10 森咪特")
    assert_equal Set["加拿大楓沛"], KibblePrices::BrandNames.split("加拿大 楓沛"), "a Chinese name split by a space stays one name"
    assert_equal Set["曙光"], KibblePrices::BrandNames.split("曙光 ")
  end

  test "learns names from the owner's kibble of the last four months, merging entries that share one" do
    user = users(:one)
    pet = pets(:one)
    pet.trackers.destroy_all
    feed = ->(brand, date) { pet.trackers.create!(date: date, food_type: "Kibble", brand: brand, description: "雞肉", amount: 1) }
    feed.("超躍", 1.week.ago.to_date)
    feed.("超躍 Hyperr", 2.months.ago.to_date)
    feed.("Canidae 良善", 1.month.ago.to_date)
    feed.("Old Brand 舊牌", 5.months.ago.to_date)
    pet.trackers.create!(date: Date.current, food_type: "Wet", brand: "Ciao 啾嚕", description: "鮪魚", amount: 1)

    groups = KibblePrices::BrandNames.for_user(user)

    assert_equal [ Set["超躍", "hyperr"], Set["canidae", "良善"] ].to_set, groups.to_set
    assert_equal Set["超躍", "hyperr"], KibblePrices::BrandNames.for_brand("超躍", groups)
    assert_equal Set["舊牌", "old brand"], KibblePrices::BrandNames.for_brand("Old Brand 舊牌", groups), "an older brand still has its own names"
  end

  test "includes the names on the bags the owner fed from" do
    pet = pets(:one)
    pet.trackers.destroy_all
    bag = dry_foods(:one)
    bag.update_columns(brand: "Royal Canin 法國皇家")
    pet.trackers.create!(date: Date.current, food_type: "Kibble", brand: "皇家", description: "室內", amount: 1, dry_food: bag)

    groups = KibblePrices::BrandNames.for_user(users(:one))

    assert_includes groups, Set["royal canin", "法國皇家"]
  end

  test "finds Chinese names anywhere and Latin names as whole words" do
    assert KibblePrices::BrandNames.in?(Set["吶一口"], "【Neko 吶一口】無穀鮮肉貓飼料")
    assert KibblePrices::BrandNames.in?(Set["mon petit"], "MonPetit貓倍麗 成貓")
    assert KibblePrices::BrandNames.in?(Set["go"], "Go! Solutions 活力系列")
    assert_not KibblePrices::BrandNames.in?(Set["go"], "GoGo貓 雞肉")
    assert_not KibblePrices::BrandNames.in?(Set["now"], "Snow 雪花 貓砂")
  end
end
