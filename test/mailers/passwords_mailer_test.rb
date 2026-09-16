require "test_helper"

class PasswordsMailerTest < ActionMailer::TestCase
  setup do
    @user = users(:one)
  end

  test "reset email is addressed to the user and renders" do
    mail = PasswordsMailer.reset(@user)
    assert_equal I18n.t("passwords_mailer.reset.subject"), mail.subject
    assert_equal [ @user.email_address ], mail.to
    assert_equal [ "ajicaretracker@gmail.com" ], mail.from
    assert_match @user.username, mail.html_part.body.decoded
  end

  # The routes carry an optional /:locale prefix, so a positionally passed token used
  # to end up in the locale slot and the email failed to render at all.
  test "the reset link points at the reset form and its token identifies the user" do
    mail = PasswordsMailer.reset(@user)

    [ mail.html_part, mail.text_part ].each do |part|
      link = part.body.decoded[%r{https?://\S+?/passwords/[^/\s"'<]+/edit}]
      assert link, "no reset link in the #{part.content_type} part"

      token = link[%r{/passwords/([^/]+)/edit}, 1]
      assert_equal @user, User.find_by_password_reset_token!(CGI.unescape(token))
    end
  end

  test "the reset link keeps the recipient's language" do
    I18n.with_locale(:ja) do
      link = PasswordsMailer.reset(@user).text_part.body.decoded[%r{https?://\S+}]
      assert_includes link, "/ja/passwords/"
    end
  end
end
