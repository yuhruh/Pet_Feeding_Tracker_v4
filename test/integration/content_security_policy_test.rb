require "test_helper"

# Fast checks, no browser: the policy is sent, every inline <script> carries the
# page's nonce, and no page relies on inline event handlers (onclick= etc.),
# which the policy blocks. test/system/content_security_policy_test.rb covers
# what only a real browser can see.
class ContentSecurityPolicyTest < ActionDispatch::IntegrationTest
  test "the policy only allows scripts from known sources and with the page's nonce" do
    get new_session_url(locale: I18n.default_locale)
    policy = response.headers["Content-Security-Policy"]
    assert policy.present?, "no Content-Security-Policy header"

    script_src = policy[/script-src ([^;]+)/, 1]
    assert_includes script_src, "'self'"
    assert_match(/'nonce-[^']+'/, script_src)
    assert_not_includes script_src, "'unsafe-inline'"
    assert_not_includes script_src, "'unsafe-eval'"
    assert_includes policy, "object-src 'none'"
    assert_includes policy, "base-uri 'self'"
    assert_includes policy, "frame-ancestors 'self'"
  end

  test "public pages use the nonce and no inline event handlers" do
    [ root_url, new_session_url(locale: I18n.default_locale), new_registrations_url(locale: I18n.default_locale),
      shared_pet_trackers_url(share_token: pets(:one).share_token, locale: I18n.default_locale) ].each do |url|
      get url
      assert_csp_compatible_page url
    end
  end

  test "signed-in pages use the nonce and no inline event handlers" do
    log_in_as(users(:one))
    pet = pets(:one)
    [ pets_url, pet_trackers_url(pet), new_pet_tracker_url(pet), pet_health_checks_url(pet),
      new_dry_food_url, edit_users_url ].each do |url|
      get url
      assert_csp_compatible_page url
    end

    # a form error page renders the error box, which used to carry its own inline script
    post pets_url, params: { pet: { petname: "A" } }
    assert_response :unprocessable_entity
    assert_select "#error-explanation"
    assert_csp_compatible_page "pet form with errors"
  end

  private
    def assert_csp_compatible_page(where)
      assert_includes [ 200, 422 ], response.status, "#{where} returned #{response.status}"
      nonce = response.headers["Content-Security-Policy"].to_s[/'nonce-([^']+)'/, 1]
      assert nonce.present?, "#{where}: no nonce in the policy"

      response.parsed_body.css("script:not([src])").each do |script|
        next if script["type"] == "importmap" && script["nonce"] == nonce
        assert_equal nonce, script["nonce"], "#{where}: inline <script> without the page's nonce:\n#{script.to_html[0, 200]}"
      end

      handlers = response.parsed_body.xpath("//@*[starts-with(name(), 'on')]").map { |attr| "#{attr.parent.name}[#{attr.name}]" }
      assert_empty handlers, "#{where}: inline event handlers are blocked by the policy: #{handlers.uniq.join(', ')}"
    end
end
