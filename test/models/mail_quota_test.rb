require "test_helper"
require "minitest/mock"

# The day's mail limit keeps room for password resets (security scan F14).
class MailQuotaTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  def with_count(count, &block)
    Rails.cache.stub(:increment, count) { Rails.cache.stub(:decrement, nil, &block) }
  end

  test "other mail stops at the limit minus the reserve; account safety mail may use the reserve" do
    with_count(MailQuota::DAILY_LIMIT - MailQuota::RESERVED) { MailQuota.take!(1, account_safety: false) }
    with_count(MailQuota::DAILY_LIMIT - MailQuota::RESERVED + 1) do
      assert_raises(MailQuota::Exhausted) { MailQuota.take!(1, account_safety: false) }
      MailQuota.take!(1, account_safety: true)
    end
    with_count(MailQuota::DAILY_LIMIT + 1) do
      assert_raises(MailQuota::Exhausted) { MailQuota.take!(1, account_safety: true) }
    end
  end

  test "an invitation over the limit is not sent but tried again the next day; a password reset still goes" do
    with_count(MailQuota::DAILY_LIMIT - MailQuota::RESERVED + 1) do
      invitation = households(:one).invitations.create!(email: "mom@example.com", invited_by: users(:one))
      HouseholdMailer.with(invitation: invitation, token: invitation.token, locale: "en").invitation.deliver_later
      # Only what is due now: the retry is scheduled for the next day.
      perform_enqueued_jobs(only: QuotaAwareMailDeliveryJob, at: Time.current)
      assert_empty ActionMailer::Base.deliveries
      retry_at = enqueued_jobs.find { |job| job[:job] == QuotaAwareMailDeliveryJob }&.dig(:at)
      assert retry_at && retry_at > Time.now.to_f + 60, "tried again the next day"

      assert_emails(1) { PasswordsMailer.reset(users(:one)).deliver_now }
    end
  end
end
