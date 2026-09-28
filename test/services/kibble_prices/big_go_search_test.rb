require "test_helper"
require "minitest/mock"

class KibblePrices::BigGoSearchTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  setup do
    @page = file_fixture("kibble_prices/biggo_royal_canin.html").read
    @no_results = file_fixture("kibble_prices/biggo_no_results.html").read
  end

  test "reads each listing's title, price, shop and shop link from a real page" do
    rows = KibblePrices::BigGoSearch.parse(@page)

    assert_equal 6, rows.size
    multi_size = rows.first
    assert_equal "Royal Canin 法國皇家 FHN 皇家室內成貓飼料 IN27 4KG/10KG", multi_size[:title]
    assert_equal "4kg 1個 雞", multi_size[:variant]
    assert_equal 1800, multi_size[:price_twd], "a variant's own price, not the listing's range"
    assert_equal "酷澎 Coupang", multi_size[:store]
    assert_equal "coupang.onelink.me", URI(multi_size[:url]).host

    yahoo = rows.second
    assert_equal [ "Royal Canin法國皇家 IN27室內成貓飼料 4kg", nil, 1425, "Yahoo購物中心" ], yahoo.values_at(:title, :variant, :price_twd, :store)
    assert_equal "tw.buy.yahoo.com", URI(yahoo[:url]).host, "the shop's own page, never BigGo's /r/ redirect"
    assert rows.none? { |row| row[:url].include?("biggo.com.tw/r/") }
  end

  test "a price range without a variant has no single price" do
    assert_nil KibblePrices::BigGoSearch.price_of("$1,800 ~ $3,450")
    assert_equal 1449, KibblePrices::BigGoSearch.price_of("$1,449")
  end

  test "fetches a query once a month" do
    calls = 0
    get = ->(url) { calls += 1; assert_match %r{\Ahttps://biggo\.com\.tw/s/}, url; [ 200, @page ] }

    Rails.stub(:cache, ActiveSupport::Cache::MemoryStore.new) do
      KibblePrices::PoliteHttp.stub(:get, get) do
        2.times { assert_equal 6, KibblePrices::BigGoSearch.call("皇家 室內成貓").size }
      end
    end
    assert_equal 1, calls
  end

  test "a failed request is not cached" do
    calls = 0
    Rails.stub(:cache, ActiveSupport::Cache::MemoryStore.new) do
      KibblePrices::PoliteHttp.stub(:get, ->(_) { calls += 1; [ 429, "" ] }) do
        2.times { assert_empty KibblePrices::BigGoSearch.call("皇家") }
      end
    end
    assert_equal 2, calls
  end

  test "an empty page alerts the admin once a day, a 'no results' page does not" do
    Rails.stub(:cache, ActiveSupport::Cache::MemoryStore.new) do
      KibblePrices::PoliteHttp.stub(:get, [ 200, @no_results ]) do
        assert_no_enqueued_emails { KibblePrices::BigGoSearch.fetch("吶一口 室內貓雙響宴") }
      end
      KibblePrices::PoliteHttp.stub(:get, [ 200, "<html><body>new layout</body></html>" ]) do
        assert_enqueued_emails(1) { 2.times { KibblePrices::BigGoSearch.fetch("皇家") } }
      end
    end
  end
end
