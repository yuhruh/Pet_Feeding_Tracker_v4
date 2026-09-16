require "test_helper"

class SecurityMailerTest < ActionMailer::TestCase
  test "the forced reset email explains what happened in every language and links to Forgot password" do
    user = users(:one)
    mail = SecurityMailer.password_reset_required(user)

    assert_equal [ user.email_address ], mail.to
    SecurityMailer::LOCALES.each do |locale|
      assert_includes mail.subject, I18n.t("security_mailer.password_reset_required.subject", locale: locale)
      [ mail.html_part, mail.text_part ].each do |part|
        body = part.body.decoded
        assert_includes body, Rails.application.routes.url_helpers.new_password_url(locale: locale, host: "example.com")
        assert_includes body, I18n.t("security_mailer.password_reset_required.what_we_did", locale: locale)
      end
    end
    assert_includes mail.html_part.body.decoded, user.username
  end
end
