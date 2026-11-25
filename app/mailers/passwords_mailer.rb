class PasswordsMailer < ApplicationMailer
  # May use the part of the daily mail limit kept for account safety (MailQuota).
  self.account_safety_mail = true

  def reset(user)
    @user = user
    mail subject: t(".subject"), to: user.email_address
  end
end
