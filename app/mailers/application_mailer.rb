class ApplicationMailer < ActionMailer::Base
  default from: "ajicaretracker@gmail.com"
  layout "mailer"

  # Every email counts toward the day's sending limit (MailQuota); mail over it
  # waits for the next day. Password resets and security mail may use the part
  # of the limit kept for them.
  class_attribute :account_safety_mail, default: false
  self.delivery_job = QuotaAwareMailDeliveryJob

  before_deliver do
    MailQuota.take!(Array(message.to).size + Array(message.cc).size + Array(message.bcc).size, account_safety: account_safety_mail)
  end
end
