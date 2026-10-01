require "test_helper"

module ApplicationCable
  # Live updates: signed-in people and viewer pages (no account) can both connect;
  # what they hear is limited by the signed stream names their pages were given.
  class ConnectionTest < ActionCable::Connection::TestCase
    test "connects a signed-in person as themselves" do
      session = users(:one).sessions.create!(user_agent: "test", ip_address: "127.0.0.1")
      cookies.signed[:session_id] = session.id
      connect
      assert_equal users(:one), connection.current_user
    end

    test "connects a viewer page without an account" do
      connect
      assert_nil connection.current_user
    end
  end
end
