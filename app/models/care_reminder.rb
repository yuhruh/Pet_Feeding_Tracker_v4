# One reminder sent to one person (checkpoint H): a routine's due day or a
# scheduled dose. The key is unique per person, so nothing is sent twice; a
# routine reminder can have one follow-up.
class CareReminder < ApplicationRecord
  CHANNELS = %w[line email].freeze

  belongs_to :household
  belongs_to :user
  belongs_to :care_routine, optional: true
  belongs_to :medication, optional: true

  validates :key, presence: true, uniqueness: { scope: :user_id }
  validates :channel, inclusion: { in: CHANNELS }
  validates :due_on, :sent_at, presence: true

  def self.routine_key(routine, due_on) = "routine:#{routine.id}:#{due_on.iso8601}"
  def self.dose_key(medication, date, time) = "dose:#{medication.id}:#{date.iso8601}:#{time}"
end
