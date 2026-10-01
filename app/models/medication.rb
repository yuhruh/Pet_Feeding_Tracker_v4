# A medication the owner set up for a cat: a dose at set times of day, or as
# needed. Stopping it keeps every dose already recorded.
class Medication < ApplicationRecord
  MAX_TIMES = 4
  # A dose with nothing recorded this long after its time is overdue.
  OVERDUE_AFTER = 1.hour

  # One scheduled dose on a day: due, given, couldn't give or overdue.
  Dose = Struct.new(:medication, :time, :at, :event, keyword_init: true) do
    def status(now = Time.current)
      return event.dose_status if event
      now > at + OVERDUE_AFTER ? "overdue" : "due"
    end

    def recorded? = event.present?
  end

  belongs_to :pet
  has_many :care_events, dependent: :restrict_with_error

  normalizes :times, with: ->(times) { Array(times).map { |time| time.to_s.strip.first(5) }.compact_blank.uniq.sort }

  validates :name, presence: true, length: { maximum: 60 }
  validates :dose, length: { maximum: 40 }
  validates :starts_on, presence: true
  validate :times_are_times, :ends_after_start

  before_validation(on: :create) { self.starts_on ||= Date.current }

  scope :current, -> { where(stopped_at: nil) }

  def as_needed? = times.empty?

  def active_on?(date)
    stopped_at.nil? && starts_on <= date && (ends_on.nil? || ends_on >= date)
  end

  # Today's scheduled doses, each with the record for it, if any. `events` are
  # the day's kept meds records.
  def doses_on(date, zone, events)
    times.map do |time|
      hour, minute = time.split(":").map(&:to_i)
      at = zone.local(date.year, date.month, date.day, hour, minute)
      event = events.select { |e| e.medication_id == id && e.dose_time == time }.max_by(&:occurred_at)
      Dose.new(medication: self, time: time, at: at, event: event)
    end
  end

  # "Clavamox 1 tablet"
  def label = [ name, dose ].compact_blank.join(" ")

  private

  def times_are_times
    errors.add(:times, :too_many, count: MAX_TIMES) if times.size > MAX_TIMES
    errors.add(:times, :invalid) unless times.all? { |time| time.match?(/\A([01]\d|2[0-3]):[0-5]\d\z/) }
  end

  def ends_after_start
    errors.add(:ends_on, :before_start) if starts_on && ends_on && ends_on < starts_on
  end
end
