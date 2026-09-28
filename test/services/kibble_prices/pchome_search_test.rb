require "test_helper"
require "minitest/mock"

class KibblePrices::PchomeSearchTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  # The shape of a real PChome search response (2026-09-28), cut to what is read.
  RESPONSE = {
    "TotalRows" => 2,
    "Prods" => [
      { "Id" => "DEBV7O-A900IOXZ3", "Name" => "Royal Canin 法國皇家 室內成貓IN27 4KG", "Price" => 1449 },
      { "Id" => "DEBV7O-A900IOXYG", "Name" => "Royal Canin 法國皇家 室內成貓IN27 10KG", "Price" => 2999 }
    ]
  }.to_json

  test "reads each product's name, price and page" do
    rows = KibblePrices::PoliteHttp.stub(:get, [ 200, RESPONSE ]) { KibblePrices::PchomeSearch.fetch("皇家 室內成貓") }

    assert_equal 2, rows.size
    assert_equal({ source: "PChome", store: "PChome 24h購物", title: "Royal Canin 法國皇家 室內成貓IN27 4KG", variant: nil,
                   price_twd: 1449, url: "https://24h.pchome.com.tw/prod/DEBV7O-A900IOXZ3" }, rows.first)
  end

  test "a failure means no PChome listings, not an error" do
    KibblePrices::PoliteHttp.stub(:get, ->(_) { raise Net::ReadTimeout }) do
      assert_nil KibblePrices::PchomeSearch.fetch("皇家")
    end
    KibblePrices::PoliteHttp.stub(:get, [ 403, "" ]) do
      assert_nil KibblePrices::PchomeSearch.fetch("皇家")
    end
  end

  test "an answer in an unexpected shape alerts the admin" do
    Rails.stub(:cache, ActiveSupport::Cache::MemoryStore.new) do
      KibblePrices::PoliteHttp.stub(:get, [ 200, "<html>maintenance</html>" ]) do
        assert_enqueued_emails(1) { assert_equal [], KibblePrices::PchomeSearch.fetch("皇家") }
      end
    end
  end
end
