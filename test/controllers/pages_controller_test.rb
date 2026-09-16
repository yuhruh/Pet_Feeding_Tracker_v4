require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  # Google requires the privacy policy and terms to be reachable without signing in,
  # and the app offers them in every language.
  test "the public pages are reachable without signing in, in every language" do
    I18n.available_locales.each do |locale|
      I18n.with_locale(locale) do
        { about: about_url(locale: locale), doc: doc_url(locale: locale),
          privacy: privacy_url(locale: locale), terms: terms_url(locale: locale) }.each do |name, url|
          get url
          assert_response :success, "#{name} (#{locale}) was #{response.status}"
        end
      end
    end
  end

  test "the privacy page names the data the app holds and how Gmail access is used" do
    get privacy_url(locale: I18n.default_locale)
    body = response.parsed_body.text
    assert_includes body, I18n.t("privacy_page.title")
    assert_match(/gmail/i, body)
    assert_match(/ajicaretracker@gmail\.com/, body)
  end

  test "the terms page says the app is not veterinary advice" do
    get terms_url(locale: I18n.default_locale)
    assert_match(/veterinar/i, response.parsed_body.text)
  end

  test "both pages are linked from the footer" do
    get about_url(locale: I18n.default_locale)
    assert_select "footer a[href=?]", privacy_path(locale: I18n.default_locale)
    assert_select "footer a[href=?]", terms_path(locale: I18n.default_locale)
  end
end
