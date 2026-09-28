require "application_system_test_case"

class KibblePricesTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  setup do
    @user = users(:one)
    @pet = pets(:one)
  end

  def add_check(checked_on)
    check = @pet.kibble_price_checks.create!(checked_on: checked_on, status: :done, kibbles: [
      { "brand" => "曙光", "description" => "無穀滋養鴨肉食譜", "favorite_score" => 45, "queries" => [], "found" => 2 },
      { "brand" => "天然密碼", "description" => "無穀鴨肉&火雞肉 全齡貓配方", "favorite_score" => 44, "queries" => [], "found" => 0 }
    ])
    price = { brand: "曙光", description: "無穀滋養鴨肉食譜", source: "PChome", store: "PChome 24h購物", bag_size_label: "3磅", bag_size_kg: 1.361 }
    check.kibble_prices.create!(price.merge(product_title: "Spring Natural 曙光 無穀滋養鴨肉 3磅", price_twd: 690, price_per_kg: 507.0,
                                            url: "https://24h.pchome.com.tw/prod/DEBV7O"))
    check.kibble_prices.create!(price.merge(source: "BigGo", store: "Yahoo拍賣", product_title: "曙光貓無穀 滋養鴨肉食譜300克", price_twd: 199,
                                            bag_size_label: "300克", bag_size_kg: 0.3, price_per_kg: 663.3, url: "https://tw.bid.yahoo.com/item/1"))
  end

  test "from the pet's profile to its ranked kibble prices" do
    add_check(1.month.ago.to_date)
    sign_in_as @user

    visit pet_url(@pet, locale: I18n.default_locale)
    click_on "Kibble Prices"

    assert_selector "h1", text: "#{@pet.petname.capitalize}'s Kibble Prices"
    within("table") do
      assert_equal [ "PChome 24h購物", "Yahoo拍賣" ], all("tbody tr td:nth-child(2)").map(&:text)
      assert_text "NT$507.0"
      assert_text "✔ Listed · PChome"
    end
    assert_text "Can't find this kibble in shops right now."
  end

  test "refresh now queues a check, once a day" do
    sign_in_as @user
    visit pet_kibble_prices_url(@pet, locale: I18n.default_locale)
    assert_text "No prices yet"

    click_on "Refresh now"
    assert_text "Checking prices now" # waits for the request, which the browser sends in the background
    assert_equal [ PetKibblePriceJob ], enqueued_jobs.map { |job| job[:job] }

    add_check(Date.current)
    visit pet_kibble_prices_url(@pet, locale: I18n.default_locale)
    assert_no_button "Refresh now"
    assert_text "Checked today; you can refresh again tomorrow."
  end

  test "phones get one card per price instead of the table" do
    add_check(Date.current)
    sign_in_as @user
    page.driver.browser.manage.window.resize_to(390, 900)

    visit pet_kibble_prices_url(@pet, locale: I18n.default_locale)

    assert_no_selector "table"
    assert_selector "ol li", count: 2
    assert_selector "ol li:first-child", text: "1. NT$507.0 / kg"
  ensure
    page.driver.browser.manage.window.resize_to(1400, 1400)
  end
end
