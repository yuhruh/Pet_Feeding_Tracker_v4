class SecurityMailer < ApplicationMailer
  LOCALES = %w[en zh-TW ja].freeze

  # Sent by `bin/rails security:force_password_reset` after the account's password was replaced.
  # Users have no saved language, so the email is written in every language the app supports.
  def password_reset_required(user)
    @user = user
    subject = LOCALES.map { |locale| I18n.t("security_mailer.password_reset_required.subject", locale: locale) }.uniq.join(" / ")
    mail subject: subject, to: user.email_address
  end
end
