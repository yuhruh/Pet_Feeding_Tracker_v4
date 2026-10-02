require "test_helper"

# Google, LINE and GitHub sign-in in the Android app (checkpoint I2). Two
# browsers, as on the phone: the app's WebView, and Chrome (a Custom Tab) where
# the whole provider sign-in happens. A one-time code brings the result back.
class NativeSignInTest < ActionDispatch::IntegrationTest
  APP = { "HTTP_USER_AGENT" => "Hotwire Native Android; Turbo Native Android; bridge-components: [toast push]; Mozilla/5.0 (Linux; Android 17; Pixel 9; wv)" }
  CHROME = { "HTTP_USER_AGENT" => "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Mobile Safari/537.36" }
  L = { locale: I18n.default_locale }.freeze
  HOST = "http://www.example.com".freeze

  # Paths, not *_url helpers: this test drives its own two sessions.
  def routes = Rails.application.routes.url_helpers
  def url(path) = "#{HOST}#{path}"

  setup do
    OmniAuth.config.test_mode = true
    mock_google(email: "mom@example.com", name: "Mom")
    @webview = open_session
    @chrome = open_session
  end

  teardown do
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  def mock_google(email:, name: "Mom", uid: "g-#{email}")
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(provider: "google_oauth2", uid: uid, info: { email: email, name: name })
  end

  # In the app: the sign-in page's Google link, which the app opens in Chrome.
  def google_link_in_app(page = routes.new_session_path(**L))
    @webview.get page, headers: APP
    link = @webview.css_select("a[href*='/auth/native/google_oauth2']").first
    assert link, "the app's sign-in page has a Google link for Chrome"
    link["href"]
  end

  # In Chrome: the start page, the provider (mocked), the callback; returns the code.
  def sign_in_in_chrome(link)
    @chrome.get link, headers: CHROME
    assert_equal 200, @chrome.response.status
    form = @chrome.css_select("form#native_sign_in").first
    assert_equal "/auth/google_oauth2", form["action"]
    # The page's script adds the browser's time zone to the address, as on the website.
    @chrome.post "/auth/google_oauth2?timezone=Asia/Taipei", params: { authenticity_token: csrf_token(form) }.compact, headers: CHROME
    @chrome.follow_redirect!(headers: CHROME.dup) # the callback
    app_link = @chrome.css_select("a#open_app").first
    assert app_link, "Chrome shows the way back to the app"
    uri = URI(app_link["href"])
    assert_equal [ "pettracker", "sign-in" ], [ uri.scheme, uri.host ]
    Rack::Utils.parse_query(uri.query)["code"]
  end

  def finish_in_app(code)
    @webview.get routes.native_sign_in_finish_path(code: code), headers: APP
  end

  def signed_in_session?(session) = session.cookies["session_id"].present?

  test "on the website the buttons still post to the provider; in the app they're links for Chrome" do
    get routes.new_session_path(**L)
    assert_select "form[action='/auth/google_oauth2'][method=post]"
    assert_select "a[href*='/auth/native/']", count: 0

    @webview.get routes.new_session_path(**L), headers: APP
    assert_equal 3, @webview.css_select("a[href*='/auth/native/']").size, "Google, LINE and GitHub"
    assert_empty @webview.css_select("form[action^='/auth/']")
  end

  test "signing in with Google from the app: Chrome does the sign-in, the code signs the app in" do
    code = sign_in_in_chrome(google_link_in_app)
    mom = User.find_by!(email_address: "mom@example.com")
    assert_equal "Asia/Taipei", mom.timezone
    assert_not signed_in_session?(@chrome), "Chrome isn't signed in"
    assert_empty mom.sessions

    finish_in_app(code)
    assert_redirected_to_landing @webview, url(routes.new_pet_path(**L))
    assert_equal I18n.t("omni_auth.sessions.create.first_time_sign_in"), @webview.flash[:notice]
    assert_equal 1, mom.sessions.count, "the app is signed in"
    @webview.get routes.pets_path(**L), headers: APP
    assert_equal 200, @webview.response.status
  end

  test "a code works once, for 2 minutes, and a made-up one not at all" do
    code = sign_in_in_chrome(google_link_in_app)
    finish_in_app(code)
    assert_equal 1, Session.count

    other_app = open_session
    other_app.get routes.native_sign_in_finish_path(code: code), headers: APP
    assert_equal url(routes.new_session_path(locale: :en)), other_app.response.location
    assert_equal I18n.t("native_sign_ins.finish.expired"), other_app.flash[:alert]
    assert_equal 1, Session.count, "used once"

    late = sign_in_in_chrome(google_link_in_app)
    travel 3.minutes do
      other_app.get routes.native_sign_in_finish_path(code: late), headers: APP
      assert_equal I18n.t("native_sign_ins.finish.expired"), other_app.flash[:alert]
    end
    other_app.get routes.native_sign_in_finish_path(code: "made-up"), headers: APP
    assert_equal I18n.t("native_sign_ins.finish.expired"), other_app.flash[:alert]
    assert_equal 1, Session.count
  end

  test "an invitation opened in the app is accepted after signing in with Google" do
    owner = users(:one)
    household = households(:one)
    invitation = household.invitations.create!(email: "mom@example.com", invited_by: owner)
    link = google_link_in_app(routes.join_household_path(token: invitation.token, **L))

    finish_in_app(sign_in_in_chrome(link))
    mom = User.find_by!(email_address: "mom@example.com")
    assert household.memberships.caregiver.exists?(user: mom)
    assert invitation.reload.accepted_at
    assert_redirected_to_landing @webview, url(routes.today_path(**L))
  end

  test "the app's language is kept through Chrome" do
    link = google_link_in_app(url(routes.new_session_path(locale: "zh-TW")))
    finish_in_app(sign_in_in_chrome(link))
    assert_redirected_to_landing @webview, url(routes.new_pet_path(locale: "zh-TW"))
    assert_equal I18n.t("omni_auth.sessions.create.first_time_sign_in", locale: :"zh-TW"), @webview.flash[:notice]
  end

  test "Chrome already signed in to the website (as someone else) doesn't change the app's sign-in" do
    owner = users(:one)
    @chrome.post routes.session_path(**L), params: { email_address: owner.email_address, password: "password123" }, headers: CHROME
    assert signed_in_session?(@chrome)
    chrome_cookie = @chrome.cookies["session_id"]

    code = sign_in_in_chrome(google_link_in_app)
    mom = User.find_by!(email_address: "mom@example.com")
    assert_empty owner.connected_services.where(provider: "google_oauth2"), "Google isn't linked to the account Chrome is signed in to"
    assert_equal chrome_cookie, @chrome.cookies["session_id"], "Chrome's own sign-in is left as it was"

    finish_in_app(code)
    assert_redirected_to_landing @webview, url(routes.new_pet_path(**L))
    assert_equal 1, mom.sessions.count, "the app is signed in as the Google account's person"
  end

  test "a refusal comes back to the app with its message, signed in as nobody" do
    User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                 password: "password123", timezone: "Asia/Taipei")
    finish_in_app(sign_in_in_chrome(google_link_in_app))
    assert_redirected_to_landing @webview, url(routes.new_session_path(**L))
    assert_match(/already/i, @webview.flash[:notice].to_s)
    assert_equal 0, Session.count
  end

  test "cancelling at Google comes back to the app's sign-in page" do
    OmniAuth.config.mock_auth[:google_oauth2] = :access_denied
    link = google_link_in_app
    @chrome.get link, headers: CHROME
    @chrome.post "/auth/google_oauth2", params: { authenticity_token: csrf_token(@chrome.css_select("form#native_sign_in").first) }.compact, headers: CHROME
    @chrome.follow_redirect!(headers: CHROME.dup) # the callback, refused
    @chrome.follow_redirect!(headers: CHROME.dup) # /auth/failure
    code = Rack::Utils.parse_query(URI(@chrome.css_select("a#open_app").first["href"]).query)["code"]

    finish_in_app(code)
    assert_redirected_to_landing @webview, url(routes.new_session_path(**L))
    assert_equal I18n.t("omni_auth.sessions.failure.cancelled"), @webview.flash[:alert]
  end

  test "an unknown provider isn't started, and a forged context carries nothing" do
    @chrome.get routes.native_sign_in_path(provider: "facebook"), headers: CHROME
    assert_equal 404, @chrome.response.status

    @chrome.get routes.native_sign_in_path(provider: "google_oauth2", context: "forged"), headers: CHROME
    assert_nil @chrome.session[:invitation_token]
  end

  test "the website's Google sign-in is unchanged, also after an abandoned app sign-in in the same Chrome" do
    @chrome.get google_link_in_app, headers: CHROME # started from the app, then abandoned
    travel 11.minutes do
      @chrome.post "/auth/google_oauth2?timezone=Asia/Taipei", params: { authenticity_token: csrf_token(@chrome.css_select("form#native_sign_in").first) }.compact, headers: CHROME
      @chrome.follow_redirect!(headers: CHROME.dup)
      assert_redirected_to_landing @chrome, url(routes.new_pet_path(**L))
      assert signed_in_session?(@chrome), "a website sign-in signs this browser in"
    end
  end

  private

  # Tests turn forgery protection off, so the form may have no token.
  def csrf_token(form) = form.at_css("input[name=authenticity_token]")&.[]("value")

  def assert_redirected_to_landing(session, url)
    assert_equal 302, session.response.status
    assert_equal url, session.response.location
  end
end
