require "test_helper"

# OAuth sign-in must verify the `state` value OmniAuth stores in the session
# when sign-in starts. A callback with a missing or forged state is rejected
# before any token is requested from the provider, which stops an attacker
# from signing a victim in, or linking an account, with the attacker's code.
class OmniauthStateTest < ActionDispatch::IntegrationTest
  PROVIDERS = {
    "google_oauth2" => "accounts.google.com",
    "line" => "access.line.me",
    "github" => "github.com"
  }.freeze

  PROVIDERS.each do |provider, host|
    test "#{provider}: starting sign-in sends a state and stores it in the session" do
      post "/auth/#{provider}"
      assert_response :redirect
      location = URI(response.location)
      assert_equal host, location.host
      state = Rack::Utils.parse_query(location.query)["state"]
      assert state.present?, "no state sent to #{provider}"
      assert_equal state, session["omniauth.state"]
    end

    test "#{provider}: callback with a forged state is rejected" do
      post "/auth/#{provider}"
      get "/auth/#{provider}/callback", params: { code: "stolen-code", state: "forged-state" }
      assert_csrf_failure
    end

    test "#{provider}: callback without a state is rejected" do
      get "/auth/#{provider}/callback", params: { code: "stolen-code" }
      assert_csrf_failure
    end

    test "#{provider}: cancelling at the provider shows the cancelled message" do
      post "/auth/#{provider}"
      get "/auth/#{provider}/callback", params: { state: session["omniauth.state"], error: "access_denied" }
      assert_response :redirect
      assert_match %r{/auth/failure\?message=access_denied}, response.location
      follow_redirect!
      assert_equal I18n.t("omni_auth.sessions.failure.cancelled"), flash[:alert]
    end
  end

  private
    def assert_csrf_failure
      assert_response :redirect
      assert_match %r{/auth/failure\?message=csrf_detected}, response.location
    end
end
