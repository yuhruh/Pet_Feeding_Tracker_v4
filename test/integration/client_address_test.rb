require "test_helper"
require "minitest/mock"

# Production sits behind Railway's edge and Thruster: the request reaches Puma from 127.0.0.1
# with "X-Forwarded-For: <visitor>, <edge address in 100.64.0.0/10>".
class ClientAddressTest < ActionDispatch::IntegrationTest
  VISITOR = "203.0.113.7"
  EDGE = "100.64.0.21"

  test "a session records the visitor's address, not Railway's edge" do
    sign_in_from "#{VISITOR}, #{EDGE}"

    assert_equal VISITOR, users(:one).sessions.order(:id).last.ip_address
  end

  test "an address the visitor made up in the header is not believed" do
    sign_in_from "198.51.100.99, #{VISITOR}, #{EDGE}"

    assert_equal VISITOR, users(:one).sessions.order(:id).last.ip_address
  end

  test "two visitors behind the same edge address don't share the sign-in limit" do
    counting_rate_limits do
      10.times { wrong_password_from "#{VISITOR}, #{EDGE}" }
      assert_response :unprocessable_entity
      wrong_password_from "#{VISITOR}, #{EDGE}"
      assert_redirected_to new_session_url, "the first visitor has used up their tries"

      wrong_password_from "198.51.100.20, #{EDGE}"
      assert_response :unprocessable_entity, "the second visitor still has theirs"
    end
  end

  private
    def sign_in_from(forwarded_for)
      post session_path, params: { email_address: users(:one).email_address, password: "password123" },
           headers: { "X-Forwarded-For" => forwarded_for }, env: { "REMOTE_ADDR" => "127.0.0.1" }
    end

    # The test cache is a null store, so count per key here, as a real store would.
    def counting_rate_limits(&block)
      counts = Hash.new(0)
      Rails.cache.stub(:increment, ->(key, *) { counts[key] += 1 }, &block)
    end

    def wrong_password_from(forwarded_for)
      post session_path, params: { email_address: users(:one).email_address, password: "wrong" },
           headers: { "X-Forwarded-For" => forwarded_for }, env: { "REMOTE_ADDR" => "127.0.0.1" }
    end
end
