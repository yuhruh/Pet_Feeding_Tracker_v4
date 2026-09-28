require "test_helper"
require "minitest/mock"

class KibblePrices::GeminiSearchTest < ActiveSupport::TestCase
  # Records the request instead of calling Gemini.
  class FakeHTTP
    attr_accessor :use_ssl, :open_timeout, :read_timeout
    attr_reader :sent_request

    def initialize(response)
      @response = response
    end

    def request(request)
      @sent_request = request
      @response
    end
  end

  FakeResponse = Struct.new(:code, :body)

  def answer(text)
    FakeResponse.new("200", { candidates: [ { content: { parts: [ { text: text } ] } } ] }.to_json)
  end

  OFFERS = <<~TEXT
    Here is what I found:
    ```json
    [
      {"store": "毛孩市集", "url": "https://www.pet-shop.example/p/123", "price_twd": 1480, "product_title": "天然密碼 無穀鴨肉&火雞肉 全齡貓 1.81kg"},
      {"store": "寵物王國", "url": "https://petking.example/item/9", "price_twd": "2,650", "product_title": "天然密碼 無穀鴨肉火雞肉 貓飼料 3.6kg"},
      {"store": "no page", "url": "", "price_twd": 999, "product_title": "天然密碼 鴨肉"},
      {"store": "no price", "url": "https://x.example/1", "price_twd": null, "product_title": "天然密碼 鴨肉"},
      {"store": "not a web page", "url": "javascript:alert(1)", "price_twd": 500, "product_title": "天然密碼 鴨肉"}
    ]
    ```
  TEXT

  test "asks Gemini with Google Search, sending the key in a header" do
    http = FakeHTTP.new(answer(OFFERS))

    rows = Net::HTTP.stub(:new, http) { KibblePrices::GeminiSearch.fetch("天然密碼 無穀鴨肉 火雞肉", "secret-key") }

    request = http.sent_request
    assert_equal "secret-key", request["x-goog-api-key"]
    assert_not_includes request.path, "secret-key"
    body = JSON.parse(request.body)
    assert_equal [ { "google_search" => {} } ], body["tools"]
    assert_match "天然密碼 無穀鴨肉 火雞肉", body.dig("contents", 0, "parts", 0, "text")

    assert_equal 2, rows.size, "offers without a page, a price or a web URL are left out"
    assert_equal({ source: "Gemini", store: "毛孩市集", title: "天然密碼 無穀鴨肉&火雞肉 全齡貓 1.81kg", variant: nil,
                   price_twd: 1480, url: "https://www.pet-shop.example/p/123" }, rows.first)
    assert_equal 2650, rows.second[:price_twd]
  end

  test "an answer without a JSON array has no offers" do
    assert_equal [], KibblePrices::GeminiSearch.parse("Sorry, I couldn't find that product.")
    assert_equal [], KibblePrices::GeminiSearch.parse("[not json]")
  end

  test "never calls Gemini without a key" do
    Net::HTTP.stub(:new, ->(*) { flunk "must not call Gemini" }) do
      assert_equal [], KibblePrices::GeminiSearch.call("天然密碼", api_key: nil)
    end
  end

  test "caches offers for the month, but not a failure" do
    calls = 0
    Rails.stub(:cache, ActiveSupport::Cache::MemoryStore.new) do
      Net::HTTP.stub(:new, ->(*) { calls += 1; FakeHTTP.new(FakeResponse.new("429", "")) }) do
        2.times { assert_equal [], KibblePrices::GeminiSearch.call("天然密碼", api_key: "k") }
      end
      assert_equal 2, calls, "a quota error is tried again next time"

      Net::HTTP.stub(:new, ->(*) { calls += 1; FakeHTTP.new(answer(OFFERS)) }) do
        2.times { assert_equal 2, KibblePrices::GeminiSearch.call("天然密碼", api_key: "k").size }
      end
    end
    assert_equal 3, calls
  end
end
