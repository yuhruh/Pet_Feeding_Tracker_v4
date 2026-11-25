class SecurityMailer < ApplicationMailer
  # May use the part of the daily mail limit kept for account safety (MailQuota).
  self.account_safety_mail = true

  LOCALES = %w[en zh-TW ja].freeze

  # Sent by `bin/rails security:force_password_reset` after the account's password was replaced.
  # Users have no saved language, so the email is written in every language the app supports.
  # disconnected: its Google, LINE and GitHub sign-ins were removed too.
  def password_reset_required(user, disconnected: false)
    @user = user
    @what_to_do = disconnected ? "what_to_do_disconnected" : "what_to_do"
    subject = LOCALES.map { |locale| I18n.t("security_mailer.password_reset_required.subject", locale: locale) }.uniq.join(" / ")
    mail subject: subject, to: user.email_address
  end

  # A Google, LINE or GitHub sign-in was linked to a signed-in account. A stolen
  # session could do that to keep a way in, so the account's email is told.
  def sign_in_method_added(user, provider)
    @user = user
    @provider = ConnectedService.provider_name(provider)
    subject = LOCALES.map { |locale| I18n.t("security_mailer.sign_in_method_added.subject", provider: @provider, locale: locale) }.uniq.join(" / ")
    mail subject: subject, to: user.email_address
  end
end
