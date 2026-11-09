# Reminds one owner to weigh pets that haven't been weighed for 14 days (or
# since they were added), and again every 14 days after that until they are.
# Run every hour by PetWeightRemindersJob, like HouseholdReminders by
# CareReminderJob; it sends between 9am and 9pm in the owner's time zone. A
# CareReminder row per pet and 14-day period makes each reminder go out once, so
# a missed run is made up by the next one. Owners not active for INACTIVE_AFTER
# get nothing (at most one reminder after they leave).
class PetWeightReminders
  EVERY = 14 # days
  INACTIVE_AFTER = 15.days
  SEND_HOURS = HouseholdReminders::SEND_HOURS
  KEY_PREFIX = "weight:"

  Due = Struct.new(:pet, :last_weighed_on, :days_since, :due_on, :key, keyword_init: true)

  def initialize(user, now: Time.current)
    @user = user
    @now = now
  end

  # Sends what's due; returns the channel used, or nil when nothing was sent.
  def deliver
    local = @now.in_time_zone(ActiveSupport::TimeZone[@user.timezone.to_s] || ActiveSupport::TimeZone["UTC"])
    return unless SEND_HOURS.cover?(local.hour)
    return if inactive?

    dues = dues_for(local)
    return if dues.empty?

    channel = PetWeightReminderNotifier.new(@user, dues).deliver
    record(dues, channel)
    channel
  end

  # Pets due a reminder that hasn't been sent: the key is the pet, the date it
  # was last weighed (or added) and which 14-day period this is, so weighing
  # again starts a new count.
  def dues_for(local)
    today = local.to_date
    sent = CareReminder.where(user: @user).where("key LIKE ?", "#{KEY_PREFIX}%").pluck(:key).to_set
    @user.owned_pets.includes(:household).order(:id).filter_map do |pet|
      weighed_on = pet.trackers.where.not(weight: nil).maximum(:date)
      since = weighed_on || pet.created_at.in_time_zone(local.time_zone).to_date
      days_since = (today - since).to_i
      period = days_since / EVERY
      next if period < 1

      key = "#{KEY_PREFIX}#{pet.id}:#{since.iso8601}:#{period}"
      next if sent.include?(key)

      Due.new(pet: pet, last_weighed_on: weighed_on, days_since: days_since, due_on: since + (period * EVERY), key: key)
    end
  end

  private

  def inactive?
    last_active = [
      @user.sessions.maximum(:last_active_at),
      @user.current_sign_in_at,
      @user.created_at
    ].compact.max

    last_active < @now - INACTIVE_AFTER
  end

  def record(dues, channel)
    CareReminder.transaction do
      dues.each do |due|
        CareReminder.create!(household: due.pet.household, user: @user, key: due.key, due_on: due.due_on, channel: channel, sent_at: @now)
      end
    end
  end
end
