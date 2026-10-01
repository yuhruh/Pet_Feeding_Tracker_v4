# What's due in one household and who to tell (checkpoints H, H2), run by the
# hourly CareReminderJob. Each owner or caregiver with reminders on gets one
# message with whatever is due for them. A CareReminder row per person makes
# each of these go out once:
# - "every" in whole days: on the due day, at or after 9am in their time zone
#   (not after 9pm); one follow-up 2 days later if still not done.
# - "every" under a day: once the due time has passed, between 9am and 9pm in
#   their time zone; one follow-up after one more interval if still not done.
# - set times: at each set time not done yet, at any hour (the owner chose it);
#   one follow-up 2 hours later if still not done.
# - a dose not recorded an hour after its time, once.
class HouseholdReminders
  SEND_HOURS = 9...21
  FOLLOW_UP_AFTER = 2 # days
  SET_TIME_FOLLOW_UP = 2.hours
  DOSE_LATE = Medication::OVERDUE_AFTER
  # A dose is reminded about only this soon after it became late, so a
  # medication added mid-day doesn't remind about this morning's dose.
  DOSE_WINDOW = 3.hours

  Item = Struct.new(:kind, :key, :due_on, :routine, :last, :medication, :dose, :reminder, :time, keyword_init: true)

  def initialize(household, now: Time.current)
    @household = household
    @now = now
    @zone = household.time_zone
  end

  # Sends what's due; returns { user => channel } for the people messaged.
  def deliver
    @household.reminder_recipients.each_with_object({}) do |user, sent|
      items = items_for(user)
      next if items.empty?

      channel = CareReminderNotifier.new(user, @household, items).deliver
      record(user, items, channel)
      sent[user] = channel
    rescue StandardError => error
      Rails.error.report(error, context: { household_id: @household.id, user_id: user.id })
    end
  end

  def items_for(user)
    local = @now.in_time_zone(ActiveSupport::TimeZone[user.timezone.to_s] || @zone)
    reminders = @household.care_reminders.where(user: user).index_by(&:key)
    routine_items(local, reminders) + dose_items(reminders)
  end

  private

  def routine_items(local, reminders)
    waking = SEND_HOURS.cover?(local.hour)
    routine_dues.flat_map do |routine, last|
      if routine.mode_set_times? then set_time_items(routine, last, reminders)
      elsif !waking then []
      elsif routine.hourly? then [ hourly_item(routine, last, reminders) ].compact
      else [ daily_item(routine, last, local, reminders) ].compact
      end
    end
  end

  def daily_item(routine, last, local, reminders)
    due_on = routine.due_on(last)
    return if due_on > local.to_date

    key = CareReminder.routine_key(routine, due_on)
    reminder = reminders[key]
    if reminder.nil?
      Item.new(kind: :routine, key: key, due_on: due_on, routine: routine, last: last)
    elsif reminder.follow_up_sent_at.nil? && local.to_date >= reminder.sent_at.in_time_zone(local.time_zone).to_date + FOLLOW_UP_AFTER
      Item.new(kind: :follow_up, key: key, due_on: due_on, routine: routine, last: last, reminder: reminder)
    end
  end

  def hourly_item(routine, last, reminders)
    due_at = routine.due_at(last).in_time_zone(@zone)
    return if due_at > @now

    key = CareReminder.routine_key(routine, due_at)
    reminder = reminders[key]
    if reminder.nil?
      Item.new(kind: :routine, key: key, due_on: due_at.to_date, routine: routine, last: last)
    elsif reminder.follow_up_sent_at.nil? && @now >= reminder.sent_at + routine.every_hours.hours
      Item.new(kind: :follow_up, key: key, due_on: due_at.to_date, routine: routine, last: last, reminder: reminder)
    end
  end

  # Set times that have come and aren't done: once at the time (within its late
  # window, so an old one isn't sent after a pause), and once more 2 hours later.
  def set_time_items(routine, last, reminders)
    today = @now.in_time_zone(@zone).to_date
    routine.slots([ today - 1, today ]).filter_map do |slot|
      next if slot.done? || slot.at > @now

      key = CareReminder.routine_key(routine, slot.at)
      reminder = reminders[key]
      if reminder.nil?
        Item.new(kind: :routine, key: key, due_on: slot.at.to_date, routine: routine, last: last, time: slot.time) if @now < slot.to
      elsif reminder.follow_up_sent_at.nil? && @now >= slot.at + SET_TIME_FOLLOW_UP && @now < slot.at + SET_TIME_FOLLOW_UP + 1.hour
        Item.new(kind: :follow_up, key: key, due_on: slot.at.to_date, routine: routine, last: last, reminder: reminder, time: slot.time)
      end
    end
  end

  def dose_items(reminders)
    late_doses.filter_map do |dose|
      key = CareReminder.dose_key(dose.medication, dose.at.to_date, dose.time)
      Item.new(kind: :dose, key: key, due_on: dose.at.to_date, medication: dose.medication, dose: dose) unless reminders.key?(key)
    end
  end

  # [routine, latest record] for the household's active spots.
  def routine_dues
    @routine_dues ||= CareRoutine.joins(:care_spot).merge(CareSpot.active).where(care_spots: { household_id: @household.id })
                                 .includes(care_spot: :household).order(:care_spot_id, :id)
                                 .map { |routine| [ routine, routine.last_done ] }
  end

  # Scheduled doses that became late within the window and have no record.
  def late_doses
    @late_doses ||= begin
      from = @now - DOSE_LATE - DOSE_WINDOW
      to = @now - DOSE_LATE
      events = @household.care_events.kept.meds.where(occurred_at: (from - 1.day)..@now).to_a
      medications = Medication.current.where(pet_id: @household.pets.select(:id)).includes(:pet).to_a
      [ from, to ].map { |time| time.in_time_zone(@zone).to_date }.uniq.flat_map do |date|
        day_events = events.select { |event| event.occurred_at.in_time_zone(@zone).to_date == date }
        medications.select { |medication| medication.active_on?(date) }.flat_map { |medication| medication.doses_on(date, @zone, day_events) }
      end.select { |dose| !dose.recorded? && dose.at.between?(from, to) }
    end
  end

  def record(user, items, channel)
    CareReminder.transaction do
      items.each do |item|
        if item.kind == :follow_up
          item.reminder.update!(follow_up_sent_at: @now)
        else
          @household.care_reminders.create!(user: user, key: item.key, due_on: item.due_on, channel: channel, sent_at: @now,
                                            care_routine: item.routine, medication: item.medication)
        end
      end
    end
  end
end
