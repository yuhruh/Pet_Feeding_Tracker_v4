# One household's day, in the household's time zone: what was recorded and when
# each cat, litter box and water spot was last looked after. Used by the Today
# page and the viewer page.
class HouseholdDay
  # One line on the timeline: a care event, or a tracker the owner logged directly.
  Entry = Struct.new(:at, :event, :tracker, keyword_init: true) do
    def pet = event&.pet || tracker&.pet
  end

  attr_reader :household, :date, :zone

  def initialize(household, date: nil)
    @household = household
    @zone = household.time_zone
    @date = date || Time.current.in_time_zone(@zone).to_date
  end

  def range = zone.local(date.year, date.month, date.day).all_day

  def pets = @pets ||= household.pets.order(:petname).to_a
  def spots = @spots ||= household.care_spots.active.to_a

  def events
    @events ||= household.care_events.kept.between(range).includes(:actor, :pet, :care_spot).order(occurred_at: :desc).to_a
  end

  # Trackers dated today, except ones already shown through their care event.
  def trackers
    @trackers ||= Tracker.where(pet_id: pets.map(&:id), date: date)
                         .where.not(id: household.care_events.where.not(tracker_id: nil).select(:tracker_id))
                         .includes(:pet).to_a
  end

  def timeline
    entries = events.map { |event| Entry.new(at: event.occurred_at, event: event) } +
              trackers.map { |tracker| Entry.new(at: tracker_time(tracker), tracker: tracker) }
    entries.sort_by(&:at).reverse
  end

  # The last feeding today (tap or tracker), as [time, who].
  def last_fed(pet)
    event = events.find { |e| e.fed? && e.pet_id == pet.id }
    tracker = trackers.select { |t| t.pet_id == pet.id }.max_by { |t| tracker_time(t) }
    candidates = [ (event && [ event.occurred_at, event.actor ]), (tracker && [ tracker_time(tracker), household.owner ]) ].compact
    candidates.max_by(&:first)
  end

  def last_weight(pet)
    household.care_events.kept.weight.where(pet: pet).order(occurred_at: :desc).includes(:actor).first
  end

  # The last record on a litter box or water spot, on any day.
  def last_done(spot)
    spot.care_events.kept.order(occurred_at: :desc).includes(:actor).first
  end

  def tracker_time(tracker)
    local = tracker.feed_time&.in_time_zone(zone)
    zone.local(tracker.date.year, tracker.date.month, tracker.date.day, local&.hour || 0, local&.min || 0)
  end
end
