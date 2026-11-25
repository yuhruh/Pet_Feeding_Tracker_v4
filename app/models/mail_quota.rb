# A daily count of everything the app emails (security scan F14). All mail goes
# out through one Gmail account, about 500 recipients a day for a free account,
# so one person sending invitations could otherwise use up the day and block
# password resets for everyone. Up to DAILY_LIMIT - RESERVED, any mail goes;
# the last RESERVED are kept for account safety mail (password resets and
# SecurityMailer). Mail over its limit waits for the next day
# (QuotaAwareMailDeliveryJob). Counted per UTC day in the shared cache; a cache
# that can't count (the test environment's null store) sets no limit.
class MailQuota
  class Exhausted < StandardError; end

  DAILY_LIMIT = ENV.fetch("MAIL_DAILY_LIMIT", 500).to_i
  RESERVED = ENV.fetch("MAIL_RESERVED_FOR_ACCOUNT_SAFETY", 100).to_i

  # Takes `recipients` from today's count, or raises Exhausted (and takes none).
  def self.take!(recipients, account_safety:)
    recipients = [ recipients.to_i, 1 ].max
    key = "mail_quota/#{Time.now.utc.to_date.iso8601}"
    count = Rails.cache.increment(key, recipients, expires_in: 2.days)
    return if count.nil?

    limit = account_safety ? DAILY_LIMIT : DAILY_LIMIT - RESERVED
    return if count <= limit

    Rails.cache.decrement(key, recipients, expires_in: 2.days)
    raise Exhausted, "daily mail limit reached (#{limit})"
  end

  # Shortly after the next UTC day starts, spread out so held mail doesn't all go at once.
  def self.wait_for_next_day
    (Time.now.utc.tomorrow.beginning_of_day - Time.now.utc) + rand(5..60).minutes
  end
end
