require "net/http"

module KibblePrices
  # The only way the price lookup reaches the network: GET requests to a fixed list
  # of hosts and paths, small, slow to repeat, and never retried.
  module PoliteHttp
    class Error < StandardError; end

    # Says who is asking instead of passing for a browser.
    USER_AGENT = "PetTrackerKibblePrices/1.0".freeze
    MAX_BYTES = 2.megabytes
    # Allowed path prefixes per host. BigGo's /r/ store links are disallowed by its
    # robots.txt, so they are shown to people but never fetched.
    ALLOWED = {
      "biggo.com.tw" => %w[/s/],
      "ecshweb.pchome.com.tw" => %w[/search/v4.3/]
    }.freeze
    # Seconds between two requests to the same host.
    MIN_INTERVAL = 2

    @last_request_at = {}
    @lock = Mutex.new

    class << self
      # Seconds to wait between requests; tests set 0.
      attr_writer :min_interval

      def min_interval
        @min_interval || MIN_INTERVAL
      end

      # Returns [status code, body]. Redirects are not followed: an allowed page
      # never needs one, and following could lead off the list.
      def get(url)
        uri = URI.parse(url)
        raise Error, "not allowed: #{url}" unless allowed?(uri)

        wait_turn(uri.host)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.open_timeout = 10
        http.read_timeout = 10

        request = Net::HTTP::Get.new(uri.request_uri, "User-Agent" => USER_AGENT, "Accept-Language" => "zh-TW")
        body = +""
        code = nil
        http.request(request) do |response|
          code = response.code.to_i
          response.read_body do |chunk|
            body << chunk
            raise Error, "response over #{MAX_BYTES} bytes: #{uri.host}" if body.bytesize > MAX_BYTES
          end
        end
        [ code, body.force_encoding(Encoding::UTF_8) ]
      end

      def allowed?(uri)
        uri.is_a?(URI::HTTPS) && uri.userinfo.nil? && uri.port == 443 &&
          ALLOWED.fetch(uri.host, []).any? { |prefix| uri.path.start_with?(prefix) }
      end

      private

      def wait_turn(host)
        @lock.synchronize do
          last = @last_request_at[host]
          pause = last ? min_interval - (Process.clock_gettime(Process::CLOCK_MONOTONIC) - last) : 0
          sleep(pause) if pause.positive?
          @last_request_at[host] = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        end
      end
    end
  end
end
