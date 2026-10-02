require "test_helper"

class KibblePriceMailerTest < ActionMailer::TestCase
  setup do
    @pet = pets(:one)
    @user = @pet.owner
    @check = @pet.kibble_price_checks.create!(checked_on: Date.new(2026, 10, 1), status: :done, kibbles: [
      { "brand" => "曙光", "description" => "無穀滋養鴨肉食譜", "favorite_score" => 45, "queries" => [], "found" => 1 },
      { "brand" => "天然密碼", "description" => "無穀鴨肉&火雞肉 全齡貓配方", "favorite_score" => 44, "queries" => [], "found" => 0 }
    ])
    price = { brand: "曙光", description: "無穀滋養鴨肉食譜", source: "PChome", store: "PChome 24h購物", product_title: "Spring Natural 曙光 無穀滋養鴨肉 3磅",
              price_twd: 690, bag_size_label: "3磅", bag_size_kg: 1.361, price_per_kg: 507.0, url: "https://24h.pchome.com.tw/prod/DEBV7O" }
    @check.kibble_prices.create!(price)
  end

  test "lists each kibble's prices in the owner's language, with a link to the page" do
    @user.update!(timezone: "Asia/Taipei")

    mail = KibblePriceMailer.monthly_report(@check)

    assert_equal [ @user.email_address ], mail.to
    assert_equal "#{@pet.petname.capitalize} 本月的飼料價格", mail.subject
    html = mail.html_part.body.decoded
    assert_match "NT$507.0", html
    assert_match "https://24h.pchome.com.tw/prod/DEBV7O", html
    assert_match "目前在商店找不到這款飼料。", html
    assert_match "/zh-TW/pets/#{@pet.id}/kibble_prices", html
    assert_match "NT$507.0/kg", mail.text_part.body.decoded
  end

  test "is in English for other time zones" do
    @user.update!(timezone: "UTC")

    mail = KibblePriceMailer.monthly_report(@check)

    assert_equal "#{@pet.petname.capitalize}'s kibble prices this month", mail.subject
    assert_match "/en/pets/#{@pet.id}/kibble_prices", mail.html_part.body.decoded
    assert_equal :en, I18n.locale, "the mailer's language does not leak into the caller"
  end
end
