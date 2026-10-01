# How often one job on a litter box or water spot is due (checkpoint H):
# "Kitchen fountain: fountain cleaned every 4 days". Due = the latest record of
# that job + the interval, or the day the interval was set + the interval, so
# doing the job early moves the next reminder.
class CareRoutine < ApplicationRecord
  include RefreshesHouseholdPages

  # The choices on the household page, in days; anything else is "custom".
  PRESETS = { "twice_a_week" => 4, "weekly" => 7, "every_2_weeks" => 14, "twice_a_month" => 15, "monthly" => 30 }.freeze
  MAX_DAYS = 365
  # How far back to look for the latest record of the job.
  RECENT_RECORDS = 500

  belongs_to :care_spot
  has_many :care_reminders, dependent: :delete_all

  validates :every_days, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: MAX_DAYS }
  validates :action, uniqueness: { scope: :care_spot_id }
  validates :started_on, presence: true
  validate :action_fits_spot

  # Saves the household page's choices for one spot: { "cleaned" => { "every" => "twice_a_week" },
  # "filter_changed" => { "every" => "custom", "days" => "10" }, "refilled" => { "every" => "off" } }.
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

      routine.every_days = every == "custom" ? choice["days"].presence : PRESETS[every]
      routine.started_on ||= today
      routine unless routine.save
    end
  end

  def household = care_spot.household

  # The latest kept record of this job on the spot.
  def last_done
    care_spot.care_events.kept.order(occurred_at: :desc).limit(RECENT_RECORDS).find { |event| event.actions.include?(action) }
  end

  def due_on(last = last_done)
    base = last ? last.occurred_at.in_time_zone(household.time_zone).to_date : started_on
    base + every_days
  end

  # The preset name for the select, or "custom".
  def preset = PRESETS.key(every_days) || "custom"

  private

  def household_to_refresh = care_spot&.household

  def action_fits_spot
    errors.add(:action, :inclusion) if care_spot && !CareEvent::SPOT_ACTIONS.fetch(care_spot.kind, []).include?(action)
  end
end
