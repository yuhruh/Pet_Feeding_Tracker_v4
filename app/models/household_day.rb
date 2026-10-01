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
                         .where.not(id: household.care_events.kept.where.not(tracker_id: nil).select(:tracker_id))
                         .includes(:pet).to_a
  end

  # The timeline covers the last 24 hours, not just today, so a late-night tap
  # can still be changed or deleted the next morning (checkpoint H3).
  TIMELINE_SPAN = 24.hours

  def timeline(now: Time.current)
    since = now - TIMELINE_SPAN
    recent_events = household.care_events.kept.where(occurred_at: since..).includes(:actor, :pet, :care_spot).to_a
    recent_trackers = Tracker.where(pet_id: pets.map(&:id), date: (since.in_time_zone(zone).to_date)..date)
                             .where.not(id: household.care_events.kept.where.not(tracker_id: nil).select(:tracker_id))
                             .includes(:pet).select { |tracker| tracker_time(tracker) >= since }
    entries = recent_events.map { |event| Entry.new(at: event.occurred_at, event: event) } +
              recent_trackers.map { |tracker| Entry.new(at: tracker_time(tracker), tracker: tracker) }
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

  # How many times each of the spot's jobs was done today: { "scooped" => 3 }.
  def today_counts(spot)
    events.select { |event| event.care_spot_id == spot.id }.flat_map(&:actions).tally
          .sort_by { |action, _| CareEvent::SPOT_ACTIONS.fetch(spot.kind).index(action) || 99 }.to_h
  end

  # The spot's reminder intervals (checkpoint H).
  def routines(spot)
    @routines ||= CareRoutine.where(care_spot_id: spots.map(&:id)).includes(:care_spot).order(:id).to_a.group_by(&:care_spot_id)
    @routines.fetch(spot.id, [])
  end

  # The cat's medications in use today.
  def medications(pet)
    @medications ||= Medication.current.where(pet_id: pets.map(&:id)).order(:name).to_a
                               .select { |medication| medication.active_on?(date) }.group_by(&:pet_id)
    @medications.fetch(pet.id, [])
  end

  # Today's scheduled doses for the cat, each with its record if there is one.
  def doses(pet)
    meds_events = events.select(&:meds?)
    medications(pet).reject(&:as_needed?).flat_map { |medication| medication.doses_on(date, zone, meds_events) }.sort_by(&:at)
  end

  # Doses not recorded yet, the one closest to now first.
  def pending_doses(pet, now: Time.current)
    doses(pet).reject(&:recorded?).sort_by { |dose| (dose.at - now).abs }
  end

  def last_given(medication)
    medication.care_events.kept.where(dose_status: "given").order(occurred_at: :desc).includes(:actor).first
  end

  def tracker_time(tracker)
    local = tracker.feed_time&.in_time_zone(zone)
    zone.local(tracker.date.year, tracker.date.month, tracker.date.day, local&.hour || 0, local&.min || 0)
  end
end
