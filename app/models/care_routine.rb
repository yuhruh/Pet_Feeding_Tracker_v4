# How often one job on a litter box or water spot is due (checkpoints H, H2).
# The owner picks one of two kinds per job:
# - every: "every 12 hours" or "every 4 days", counted from the latest record of
#   the job (or from when it was set), so doing it early moves the next one.
#   Under a day (or not whole days) it's due to the minute; whole days are due
#   on a day, as in H.
# - set_times: "at 08:00 and 20:00". Each set time is done by a record of the
#   job in its window: from a little after the previous set time to a little
#   after this one (a late scoop counts for the time just passed, an early one
#   for the next).
class CareRoutine < ApplicationRecord
  include RefreshesHouseholdPages

  # The "every …" choices on the household page, in hours; anything else is "custom".
  PRESETS = { "three_times_a_day" => 8, "twice_a_day" => 12, "daily" => 24, "twice_a_week" => 96, "weekly" => 168,
              "every_2_weeks" => 336, "twice_a_month" => 360, "monthly" => 720 }.freeze
  MAX_HOURS = 365 * 24
  MAX_TIMES = 6
  # A record this soon after a set time counts for it (done late); never more
  # than half the gap to the next set time.
  LATE_GRACE = 2.hours
  # A set time not done this long after shows as late.
  LATE_AFTER = 1.hour
  # How far back to look for the latest record of the job.
  RECENT_RECORDS = 500

  # One set time on one day, with the record that did it, if any.
  Slot = Struct.new(:time, :at, :from, :to, :event, keyword_init: true) do
    def done? = event.present?

    def status(now = Time.current)
      return "done" if done?

      now >= at + LATE_AFTER ? "late" : "due"
    end
  end

  enum :mode, { every: "every", set_times: "set_times" }, prefix: true, validate: true

  belongs_to :care_spot
  has_many :care_reminders, dependent: :delete_all

  before_validation :tidy_times

  validates :every_hours, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: MAX_HOURS }, if: :mode_every?
  validates :action, uniqueness: { scope: :care_spot_id }
  validates :started_on, presence: true
  validate :action_fits_spot, :times_are_times

  # Saves the household page's choices for one spot, e.g.
  # { "scooped" => { "every" => "set_times", "times" => [ "08:00", "20:00" ] },
  #   "full_change" => { "every" => "custom", "amount" => "10", "unit" => "days" },
  #   "cleaned" => { "every" => "twice_a_day" }, "refilled" => { "every" => "off" } }.
  # Returns the routines that couldn't be saved.
  def self.apply(spot, choices, today:)
    actions = CareEvent::SPOT_ACTIONS.fetch(spot.kind)
    spot.care_routines.where.not(action: actions).destroy_all
    actions.filter_map do |action|
      choice = choices.to_h.fetch(action, {}).to_h.stringify_keys
      every = choice["every"].to_s
      next if every.empty?

      routine = spot.care_routines.find_or_initialize_by(action: action)
      next routine.persisted? && routine.destroy && nil if every == "off"

      if every == "set_times"
        routine.assign_attributes(mode: "set_times", times: Array(choice["times"]), every_hours: nil)
      else
        routine.assign_attributes(mode: "every", every_hours: every == "custom" ? custom_hours(choice) : PRESETS[every], times: [])
      end
      routine.started_on ||= today
      routine unless routine.save
    end
  end

  def self.custom_hours(choice)
    amount = choice["amount"].to_s.strip
    return amount.presence unless amount.match?(/\A\d+\z/)

    choice["unit"] == "hours" ? amount.to_i : amount.to_i * 24
  end

  def household = care_spot.household

  # The latest kept record of this job on the spot.
  def last_done
    care_spot.care_events.kept.order(occurred_at: :desc).limit(RECENT_RECORDS).find { |event| event.actions.include?(action) }
  end

  # "every" under a day, or not in whole days: due to the minute.
  def hourly? = mode_every? && (every_hours < 24 || (every_hours % 24).nonzero?)

  # "every" in whole days: due on a day, counted in the household's time zone.
  def due_on(last = last_done)
    base = last ? last.occurred_at.in_time_zone(household.time_zone).to_date : started_on
    base + every_hours / 24
  end

  # "every" under a day: the moment it's due.
  def due_at(last = last_done)
    (last ? last.occurred_at : created_at) + every_hours.hours
  end

  # The set times on these days (household's), each with the record that did it.
  def slots(dates)
    zone = household.time_zone
    dates = Array(dates)
    ats = ((dates.min - 1)..(dates.max + 1)).flat_map do |date|
      times.map { |time| zone.local(date.year, date.month, date.day, *time.split(":").map(&:to_i)) }
    end.sort
    records = care_spot.care_events.kept.where(occurred_at: ats.first..ats.last).order(:occurred_at).select { |event| event.actions.include?(action) }
    ats.each_cons(3).filter_map do |previous, at, following|
      next unless dates.include?(at.to_date)

      from = previous + [ LATE_GRACE, (at - previous) / 2 ].min
      to = at + [ LATE_GRACE, (following - at) / 2 ].min
      event = records.find { |record| record.occurred_at > from && record.occurred_at <= to }
      Slot.new(time: at.strftime("%H:%M"), at: at, from: from, to: to, event: event)
    end
  end

  # The preset name for the select: a preset, "custom" or "set_times".
  def preset
    return "set_times" if mode_set_times?

    PRESETS.key(every_hours) || "custom"
  end

  # For the custom fields: [amount, unit], in days when whole days.
  def custom_amount
    return [ nil, "days" ] unless mode_every? && every_hours

    (every_hours % 24).zero? ? [ every_hours / 24, "days" ] : [ every_hours, "hours" ]
  end

  private

  def household_to_refresh = care_spot&.household

  def tidy_times
    self.times = Array(times).map { |time| time.to_s.strip }.compact_blank.uniq.sort
  end

  def action_fits_spot
    errors.add(:action, :inclusion) if care_spot && !CareEvent::SPOT_ACTIONS.fetch(care_spot.kind, []).include?(action)
  end

  def times_are_times
    return unless mode_set_times?

    errors.add(:times, :blank) if times.empty?
    errors.add(:times, :too_many, count: MAX_TIMES) if times.size > MAX_TIMES
    errors.add(:times, :invalid) unless times.all? { |time| time.match?(/\A([01]\d|2[0-3]):[0-5]\d\z/) }
  end
end
