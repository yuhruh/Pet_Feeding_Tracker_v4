# deliver_later for every mailer (ApplicationMailer.delivery_job): mail held
# back by MailQuota is tried again the next day, for up to a few days.
class QuotaAwareMailDeliveryJob < ActionMailer::MailDeliveryJob
  retry_on MailQuota::Exhausted, attempts: 4, wait: ->(_executions) { MailQuota.wait_for_next_day }
end
