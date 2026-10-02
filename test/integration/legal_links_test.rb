require "test_helper"

# Google Play requires the privacy policy link inside the app. The Android app's
# layout has no footer, so the sign-in, sign-up and account pages carry it.
class LegalLinksTest < ActionDispatch::IntegrationTest
  APP = { "HTTP_USER_AGENT" => "Hotwire Native Android; Turbo Native Android; bridge-components: [toast push]" }.freeze
  L = { locale: I18n.default_locale }.freeze

  test "the sign-in, sign-up and account pages link to the privacy policy and terms, in the app too" do
    [ new_session_url(**L), new_registrations_url(**L) ].each do |page|
      get page, headers: APP
      assert_select "#legal_links a[href='#{privacy_path(**L)}']", "Privacy"
      assert_select "#legal_links a[href='#{terms_path(**L)}']", "Terms"
    end

    log_in_as(users(:one))
    get users_url(**L), headers: APP
    assert_select "#legal_links a[href='#{privacy_path(**L)}']"
  end

  test "the privacy policy describes households, notifications and analytics, in every language" do
    { en: [ "Firebase Cloud Messaging", "PostHog", "Caregivers you invite" ],
      "zh-TW": [ "Firebase Cloud Messaging", "PostHog", "照顧者" ],
      ja: [ "Firebase Cloud Messaging", "PostHog", "お世話メンバー" ] }.each do |locale, phrases|
      get privacy_url(locale: locale)
      assert_response :success
      phrases.each { |phrase| assert_includes response.body, phrase, "#{locale}: #{phrase}" }
    end
  end
end
