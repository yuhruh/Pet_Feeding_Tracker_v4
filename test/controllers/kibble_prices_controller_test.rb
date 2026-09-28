require "test_helper"

class KibblePricesControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    log_in_as(users(:one))
    @pet = pets(:one)
  end

  # A request in another language leaves I18n.locale set for the rest of the process.
  teardown { I18n.locale = I18n.default_locale }

  def finished_check(checked_on: Date.current)
    check = @pet.kibble_price_checks.create!(checked_on: checked_on, status: :done, kibbles: [
      { "brand" => "曙光", "description" => "無穀滋養鴨肉食譜", "favorite_score" => 45, "queries" => [ "曙光 無穀滋養鴨肉食譜" ], "found" => 3 },
      { "brand" => "天然密碼", "description" => "無穀鴨肉&火雞肉 全齡貓配方", "favorite_score" => 44, "queries" => [], "found" => 0 }
    ])
    add_price(check, "PChome 24h購物", "Spring Natural 曙光 無穀滋養鴨肉 3磅", 690, "3磅", 1.361, 507.0, source: "PChome",
              url: "https://24h.pchome.com.tw/prod/DEBV7O")
    add_price(check, "Yahoo拍賣", "曙光貓無穀 滋養鴨肉食譜300克", 199, "300克", 0.3, 663.3, url: "javascript:alert(1)")
    check
  end

  def add_price(check, store, title, price, label, kg, per_kg, source: "BigGo", **attrs)
    check.kibble_prices.create!(brand: "曙光", description: "無穀滋養鴨肉食譜", favorite_score: 45, source: source, store: store,
                                product_title: title, price_twd: price, bag_size_label: label, bag_size_kg: kg, price_per_kg: per_kg, **attrs)
  end

  test "shows the latest check, cheapest per kg first, and says when a kibble can't be found" do
    finished_check(checked_on: 1.month.ago.to_date).kibble_prices.update_all(price_per_kg: 1)
    finished_check

    get pet_kibble_prices_url(@pet)

    assert_response :success
    rows = css_select("table tbody tr")
    assert_equal 2, rows.size
    assert_match "NT$507.0", rows.first.text
    assert_match "3磅 (1.361 kg)", rows.first.text
    assert_match "✔ Listed · PChome", rows.first.text
    assert_select "a[href='https://24h.pchome.com.tw/prod/DEBV7O'][target=_blank][rel='noopener noreferrer nofollow']"
    assert_select "a[href^='javascript']", count: 0
    assert_match "Can&#39;t find this kibble in shops right now.", response.body
    assert_no_match(/gemini|unverified|suspicious/i, css_select("section").map(&:text).join, "no traces of the Gemini backup")
  end

  test "says when there is nothing to show yet" do
    get pet_kibble_prices_url(@pet)
    assert_match "No prices yet", response.body

    @pet.kibble_price_checks.create!(checked_on: Date.current)
    get pet_kibble_prices_url(@pet)
    assert_match "Checking prices now", response.body

    @pet.kibble_price_checks.sole.update!(status: :failed, error_message: "RuntimeError: BigGo is down")
    get pet_kibble_prices_url(@pet)
    assert_match "The last price check", response.body
    assert_no_match "BigGo is down", response.body, "error details stay in the logs"
  end

  test "is in the page's language" do
    finished_check

    get pet_kibble_prices_url(@pet, locale: "zh-TW")

    assert_select "h1", text: /的飼料價格/
    assert_match "每公斤", response.body
  end

  test "refresh queues a check once a day" do
    assert_enqueued_with(job: PetKibblePriceJob, args: [ @pet, Date.current ]) do
      post pet_kibble_prices_url(@pet)
    end
    assert_redirected_to pet_kibble_prices_url(@pet, locale: I18n.default_locale)
    assert_equal I18n.t("kibble_prices.create.queued"), flash[:notice]

    finished_check
    assert_no_enqueued_jobs(only: PetKibblePriceJob) { post pet_kibble_prices_url(@pet) }
    assert_equal I18n.t("kibble_prices.create.already_checked"), flash[:notice]

    get pet_kibble_prices_url(@pet)
    assert_select "form[action='#{pet_kibble_prices_path(@pet)}']", count: 0, message: "no refresh button once checked today"
  end

  test "only the pet's owner can see or refresh its prices" do
    other = pets(:two)

    get pet_kibble_prices_url(other)
    assert_redirected_to pets_url(locale: I18n.default_locale)

    assert_no_enqueued_jobs { post pet_kibble_prices_url(other) }
    assert_redirected_to pets_url(locale: I18n.default_locale)
  end

  test "the pet page and the favorite list link here" do
    get pet_url(@pet)
    assert_select "a[href='#{pet_kibble_prices_path(@pet)}']"

    get favorite_food_pet_trackers_url(@pet)
    assert_select "a[href='#{pet_kibble_prices_path(@pet)}']"
  end
end
