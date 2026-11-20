require "test_helper"

# Profile → "Sign-in methods": every way into the account, with Disconnect for
# a connected Google, LINE or GitHub and Connect for the others.
class SignInMethodsTest < ActionDispatch::IntegrationTest
  APP = { "HTTP_USER_AGENT" => "Hotwire Native Android; Turbo Native Android; bridge-components: [toast push]; Mozilla/5.0 (Linux; Android 17; Pixel 9; wv)" }

  setup do
    @user = users(:one)
    @other = users(:two)
    ConnectedService.delete_all # the fixtures' placeholders
    OmniAuth.config.test_mode = true
    mock_github("gh-mine")
  end

  teardown do
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:github] = nil
  end

  def mock_github(uid)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(provider: "github", uid: uid, info: { email: "whoever@example.net", name: "Whoever" })
  end

  def row(provider) = css_select("#sign-in-methods [data-sign-in-method=#{provider}]").first

  test "the profile lists the password and the three providers with their state and action" do
    @user.connected_services.create!(provider: "google_oauth2", uid: "g-mine")
    log_in_as @user
    get users_path

    assert_select "#sign-in-methods h2", I18n.t("users.sign_in_methods.title")
    assert_select "#sign-in-methods", text: /#{Regexp.escape(@user.email_address)}/
    assert_select "#sign-in-methods a[href=?]", edit_users_path, text: I18n.t("users.sign_in_methods.change")

    assert_includes row("google_oauth2").text, I18n.t("users.sign_in_methods.connected")
    assert_equal sign_in_method_path(provider: "google_oauth2"), row("google_oauth2").at_css("form")["action"]
    assert_equal "delete", row("google_oauth2").at_css("input[name=_method]")["value"]

    %w[line github].each do |provider|
      assert_includes row(provider).text, I18n.t("users.sign_in_methods.not_connected")
      form = row(provider).at_css("form")
      assert_equal "/auth/#{provider}?from=profile", form["action"]
      assert_equal "false", form["data-turbo"], "the provider's page is another site"
    end
  end

  test "disconnect removes that provider from this account only" do
    @user.connected_services.create!(provider: "google_oauth2", uid: "g-mine")
    @user.connected_services.create!(provider: "line", uid: "U-mine")
    theirs = @other.connected_services.create!(provider: "google_oauth2", uid: "g-theirs")
    log_in_as @user

    delete sign_in_method_path(provider: "google_oauth2")
    assert_redirected_to users_path(anchor: "sign-in-methods")
    assert_equal I18n.t("sign_in_methods.destroy.notice", provider: "Google"), flash[:notice]
    assert_equal [ "line" ], @user.connected_services.pluck(:provider)
    assert ConnectedService.exists?(theirs.id)
  end

  test "disconnect needs a signed-in person and a real provider" do
    @user.connected_services.create!(provider: "google_oauth2", uid: "g-mine")
    delete sign_in_method_path(provider: "google_oauth2")
    assert_redirected_to new_session_path
    assert_equal 1, @user.connected_services.count

    log_in_as @user
    delete sign_in_method_path(provider: "facebook")
    assert_response :not_found
  end

  test "Connect on the profile links the provider and comes back to the profile" do
    log_in_as @user
    post "/auth/github?from=profile"
    follow_redirect! # the callback
    assert_redirected_to users_path(anchor: "sign-in-methods")
    assert_equal I18n.t("omni_auth.sessions.create.connected", provider: "GitHub"), flash[:notice]
    assert_equal [ [ "github", "gh-mine" ] ], @user.connected_services.pluck(:provider, :uid)

    follow_redirect!
    assert_includes row("github").text, I18n.t("users.sign_in_methods.connected")
  end

  test "a provider account that already signs in to someone else isn't connected, and says so" do
    theirs = @other.connected_services.create!(provider: "github", uid: "gh-theirs")
    mock_github("gh-theirs")
    log_in_as @user

    post "/auth/github?from=profile"
    follow_redirect!
    assert_redirected_to users_path(anchor: "sign-in-methods")
    assert_equal I18n.t("omni_auth.sessions.create.connected_elsewhere", provider: "GitHub"), flash[:alert]
    assert_empty @user.connected_services
    assert_equal @other.id, theirs.reload.user_id
  end

  test "in the Android app the list is there, Disconnect works and connecting is for the website" do
    @user.connected_services.create!(provider: "line", uid: "U-mine")
    post session_path, params: { email_address: @user.email_address, password: "password123" }, headers: APP
    get users_path, headers: APP

    assert row("line").at_css("form[action='#{sign_in_method_path(provider: "line")}']")
    assert_nil row("github").at_css("form"), "no Connect button: providers refuse the app's WebView"
    assert_select "#sign-in-methods", text: /#{Regexp.escape(I18n.t("users.sign_in_methods.connect_on_website"))}/
  end

  test "after a password reset the profile offers to connect again" do
    @user.connected_services.create!(provider: "github", uid: "gh-mine")
    patch password_path(token: @user.password_reset_token), params: { password: "brandnewpass1", password_confirmation: "brandnewpass1" }
    post session_path, params: { email_address: @user.email_address, password: "brandnewpass1" }
    get users_path
    assert_equal "/auth/github?from=profile", row("github").at_css("form")["action"]
  end
end
