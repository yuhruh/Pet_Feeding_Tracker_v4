require "application_system_test_case"

# Loads the main pages in Chrome with the Content-Security-Policy enforced and
# fails on any violation. That catches a new inline script, onclick= handler or
# third-party host that the policy (config/initializers/content_security_policy.rb)
# doesn't allow, including ones only a browser sees, like scripts that Google
# Charts loads at runtime.
class ContentSecurityPolicyTest < ApplicationSystemTestCase
  LOCALE = I18n.default_locale

  setup do
    # Installed through Chrome DevTools, so it runs before any page script and
    # isn't itself subject to the page's policy.
    @recorder = browser.execute_cdp("Page.addScriptToEvaluateOnNewDocument", source: <<~JS)["identifier"]
      window.__cspViolations = [];
      document.addEventListener("securitypolicyviolation", (e) => {
        window.__cspViolations.push(`${e.effectiveDirective} blocked ${e.blockedURI || "inline code"} at ${e.sourceFile || "?"}:${e.lineNumber}`);
      });
    JS
    @user = users(:one)
    @pet = pets(:one)
  end

  teardown do
    browser.execute_cdp("Page.removeScriptToEvaluateOnNewDocument", identifier: @recorder)
  end

  test "public pages load without CSP violations" do
    [ root_url, new_session_url(locale: LOCALE), new_registrations_url(locale: LOCALE),
      about_url(locale: LOCALE), doc_url(locale: LOCALE), new_password_url(locale: LOCALE) ].each do |url|
      visit url
      assert_no_csp_violations url
    end

    visit shared_pet_trackers_url(share_token: @pet.share_token, locale: LOCALE)
    wait_for_charts
    assert_no_csp_violations "shared page"
  end

  test "signed-in pages load without CSP violations" do
    sign_in_as(@user)
    assert_no_csp_violations "sign-in"

    tracker = trackers(:one)
    health_check = health_checks(:one)
    [ pets_url(locale: LOCALE), pet_url(id: @pet, locale: LOCALE), edit_pet_url(id: @pet, locale: LOCALE),
      favorite_food_pet_trackers_url(pet_id: @pet, locale: LOCALE), new_pet_tracker_url(pet_id: @pet, locale: LOCALE),
      edit_pet_tracker_url(pet_id: @pet, id: tracker, locale: LOCALE),
      pet_health_checks_url(pet_id: @pet, locale: LOCALE), new_pet_health_check_url(pet_id: @pet, locale: LOCALE),
      pet_health_check_url(pet_id: @pet, id: health_check, locale: LOCALE), edit_pet_health_check_url(pet_id: @pet, id: health_check, locale: LOCALE),
      pet_vet_visits_url(pet_id: @pet, locale: LOCALE), new_pet_vet_visit_url(pet_id: @pet, locale: LOCALE),
      dry_foods_url(locale: LOCALE), new_dry_food_url(locale: LOCALE), users_url(locale: LOCALE), edit_users_url(locale: LOCALE) ].each do |url|
      visit url
      assert_no_csp_violations url
    end

    visit pet_trackers_url(pet_id: @pet, locale: LOCALE)
    wait_for_charts
    assert_no_csp_violations "trackers list with charts"
  end

  test "controls that used inline event handlers still work" do
    sign_in_as(@user) # leaves a "Welcome back" flash message and the Gemini key banner

    find(".alert-message button[aria-label='Close']").click
    assert_no_selector ".alert-message"

    find("#gemini-key-banner button[aria-label='Dismiss']").click
    assert_no_selector "#gemini-key-banner"

    visit pet_trackers_url(pet_id: @pet, locale: LOCALE)
    find("select[name='per_page']").select("5")
    assert_current_path(/per_page=5/)

    visit new_pet_url(locale: LOCALE)
    page.execute_script("document.getElementById('pet-form').noValidate = true") # let the server validate
    find("#pet_petname").set("A") # too short: the server re-renders the form with the error box
    find("button[type=submit][form='pet-form']").click # the button sits outside the <form> and points at it
    find("#error-explanation button[aria-label='Close']").click
    assert_no_selector "#error-explanation"

    assert_no_csp_violations "closing messages"
  end

  test "the Android (Hotwire Native) layout loads without CSP violations" do
    visit "about:blank"
    default_user_agent = page.evaluate_script("navigator.userAgent")
    browser.execute_cdp("Network.setUserAgentOverride", userAgent: "#{default_user_agent} Hotwire Native Android")

    sign_in_as(@user)
    visit pet_trackers_url(pet_id: @pet, locale: LOCALE)
    wait_for_charts
    assert_no_csp_violations "native layout"
  ensure
    browser.execute_cdp("Network.setUserAgentOverride", userAgent: default_user_agent) if default_user_agent
  end

  private
    def browser
      page.driver.browser
    end

    # Google Charts loads its code after the page, so give it time to run (or be blocked).
    def wait_for_charts
      page.has_css?("#pet-chart-fixed svg", wait: 10)
    end

    def assert_no_csp_violations(where)
      violations = page.evaluate_script("window.__cspViolations || []").uniq
      page.execute_script("window.__cspViolations = []")
      assert_empty violations, "CSP violations on #{where}:\n#{violations.join("\n")}"
    end
end
