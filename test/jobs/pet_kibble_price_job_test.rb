require "test_helper"
require "minitest/mock"

class PetKibblePriceJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper
  setup do
    @pet = pets(:one)
    @pet.trackers.destroy_all
    feed("曙光", "無穀滋養鴨肉食譜", 45)
    feed("天然密碼", "無穀鴨肉&火雞肉 全齡貓配方", 44)
  end

  def feed(brand, description, score)
    @pet.trackers.create!(date: Date.current, food_type: "Kibble", brand: brand, description: description,
                          hungry: "💖 Yes, eat right away", love: "💕", amount: 30, left_amount: 0, favorite_score: score)
  end

  # BigGo lists the duck kibble only; PChome finds nothing.
  def run_job(**args)
    big_go = lambda do |query|
      next [] unless query.start_with?("曙光")

      [ KibblePrices::Listing.new(source: "BigGo", store: "Yahoo拍賣", title: "曙光貓無穀 滋養鴨肉食譜300克", variant: nil,
                                  price_twd: 199, url: "https://tw.bid.yahoo.com/item/1") ]
    end
    KibblePrices::BigGoSearch.stub(:call, big_go) do
      KibblePrices::PchomeSearch.stub(:call, []) do
        PetKibblePriceJob.perform_now(@pet, args.fetch(:checked_on, Date.current), notify: args.fetch(:notify, false))
      end
    end
  end

  test "saves each favorite kibble's prices, and a summary that includes kibbles with none" do
    run_job

    check = @pet.kibble_price_checks.sole
    assert check.done?
    assert_equal Date.current, check.checked_on

    price = check.kibble_prices.sole
    assert_equal [ "曙光", "無穀滋養鴨肉食譜", 45, "biggo", "Yahoo拍賣", "300克", 199 ],
                 price.attributes.values_at("brand", "description", "favorite_score", "source", "store", "bag_size_label", "price_twd")
    assert_equal 663.3, price.price_per_kg.to_f

    duck, turkey = check.kibbles
    assert_equal [ "曙光", 1 ], duck.values_at("brand", "found")
    assert_equal [ "天然密碼", 0 ], turkey.values_at("brand", "found"), "a kibble nothing lists is still in the summary"
    assert_equal [ "天然密碼 無穀鴨肉 火雞肉 全齡貓配方", "天然密碼 貓飼料" ], turkey["queries"]
  end

  test "checks a pet at most once a day" do
    run_job

    assert_no_difference -> { KibblePriceCheck.count } do
      run_job
    end
    assert_difference -> { KibblePriceCheck.count }, 1 do
      run_job(checked_on: Date.tomorrow)
    end
  end

  test "records a failure and lets the job fail" do
    KibblePrices::Lookup.stub(:new, ->(*) { raise "BigGo is down" }) do
      assert_raises(RuntimeError) { PetKibblePriceJob.perform_now(@pet) }
    end

    check = @pet.kibble_price_checks.sole
    assert check.failed?
    assert_equal "RuntimeError: BigGo is down", check.error_message
    assert_empty check.kibble_prices
  end

  test "the monthly run emails the owner when there are prices; a refresh doesn't" do
    assert_enqueued_emails(1) { run_job(checked_on: Date.current, notify: true) }
    assert_no_enqueued_emails { run_job(checked_on: Date.tomorrow) }
  end

  test "no email when nothing was found" do
    @pet.trackers.where(brand: "曙光").destroy_all

    assert_no_enqueued_emails { run_job(checked_on: Date.current, notify: true) }
  end

  test "runs one pet at a time across all users" do
    assert_equal PetKibblePriceJob.new(pets(:one)).concurrency_key, PetKibblePriceJob.new(pets(:two)).concurrency_key
  end
end
