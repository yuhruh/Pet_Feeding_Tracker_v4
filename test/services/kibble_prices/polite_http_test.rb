require "test_helper"
require "minitest/mock"

class KibblePrices::PoliteHttpTest < ActiveSupport::TestCase
  # Streams the body in chunks, as Net::HTTP does, and records the request.
  class FakeHTTP
    attr_accessor :use_ssl, :open_timeout, :read_timeout
    attr_reader :sent_request

    def initialize(code, body)
      @response = FakeResponse.new(code, body)
    end

    def request(request)
      @sent_request = request
      yield @response
    end
  end

  FakeResponse = Struct.new(:code, :body) do
    def read_body(&block)
      body.b.scan(/.{1,4096}/mn).each(&block)
    end
  end

  setup { KibblePrices::PoliteHttp.min_interval = 0 }
  teardown { KibblePrices::PoliteHttp.min_interval = nil }

  test "gets an allowed page and says who is asking" do
    http = FakeHTTP.new("200", "<html>璞斯</html>")

    code, body = Net::HTTP.stub(:new, http) { KibblePrices::PoliteHttp.get("https://biggo.com.tw/s/%E7%92%9E%E6%96%AF/") }

    assert_equal [ 200, "<html>璞斯</html>" ], [ code, body ]
    assert_equal "/s/%E7%92%9E%E6%96%AF/", http.sent_request.path
    assert_equal KibblePrices::PoliteHttp::USER_AGENT, http.sent_request["User-Agent"]
    assert_equal 10, http.open_timeout
  end

  test "refuses hosts and paths that are not on the list" do
    Net::HTTP.stub(:new, ->(*) { flunk "must not connect" }) do
      [
        "https://biggo.com.tw/r/?i=tw_pec_coupang&purl=https%3A%2F%2Fexample.com", # robots.txt disallows /r/
        "http://biggo.com.tw/s/x/",                                               # not HTTPS
        "https://biggo.com.tw.evil.example/s/x/",
        "https://user@biggo.com.tw/s/x/",
        "https://feebee.com.tw/s/?q=x",                                           # its terms forbid it
        "https://ecshweb.pchome.com.tw/search/v3.3/all/results?q=x"
      ].each do |url|
        assert_raises(KibblePrices::PoliteHttp::Error, url) { KibblePrices::PoliteHttp.get(url) }
      end
    end
  end

  test "stops reading a response that is too large" do
    http = FakeHTTP.new("200", "x" * (KibblePrices::PoliteHttp::MAX_BYTES + 1))

    Net::HTTP.stub(:new, http) do
      assert_raises(KibblePrices::PoliteHttp::Error) { KibblePrices::PoliteHttp.get("https://biggo.com.tw/s/x/") }
    end
  end
end
