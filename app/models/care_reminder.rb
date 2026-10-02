# One reminder sent to one person (checkpoint H): a routine's due day or a
# scheduled dose. The key is unique per person, so nothing is sent twice; a
# routine reminder can have one follow-up.
class CareReminder < ApplicationRecord
  CHANNELS = %w[android line email].freeze

  belongs_to :household
  belongs_to :user
  belongs_to :care_routine, optional: true
  belongs_to :medication, optional: true

  validates :key, presence: true, uniqueness: { scope: :user_id }
  validates :channel, inclusion: { in: CHANNELS }
  validates :due_on, :sent_at, presence: true

  # "routine:12:2026-10-03" for a due day, "routine:12:2026-10-03T20:00" for a due time.
  def self.routine_key(routine, due)
    "routine:#{routine.id}:#{due.respond_to?(:hour) ? due.strftime('%Y-%m-%dT%H:%M') : due.iso8601}"
  end
  def self.dose_key(medication, date, time) = "dose:#{medication.id}:#{date.iso8601}:#{time}"
end
