require "csv"

# The owner's download of every care record in the household (checkpoint G):
# one row per record, oldest first, in the household's time zone, with the same
# ";" separator as the trackers CSV. Undone taps are left out.
class CareRecordsCsv
  COLUMNS = %w[date time kind cat spot jobs details weight note recorded_by changed].freeze

  def initialize(household, helpers)
    @household = household
    @helpers = helpers
    @zone = household.time_zone
  end

  def filename = "care-records-#{Time.current.in_time_zone(@zone).to_date}.csv"

  def to_csv
    events = @household.care_events.kept.includes(:actor, :edited_by, :pet, :care_spot, :medication).order(:occurred_at, :id)
    CSV.generate(col_sep: ";") do |csv|
      csv << COLUMNS.map { |column| I18n.t("care_records.columns.#{column}") }
      events.find_each { |event| csv << row(event) }
    end
  end

  private

  def row(event)
    local = event.occurred_at.in_time_zone(@zone)
    [
      local.to_date.iso8601, local.strftime("%H:%M"),
      I18n.t("care_records.kinds.#{event.kind}"),
      (@helpers.pet_display_name(event.pet) if event.pet),
      (@helpers.care_spot_name(event.care_spot) if event.care_spot),
      event.actions.map { |action| @helpers.care_action_done(event.care_spot, action) }.join(", ").presence,
      details(event),
      event.value&.to_f,
      event.note,
      @helpers.care_person(event.actor),
      (I18n.t("care_records.changed", time: event.edited_at.in_time_zone(@zone).strftime("%Y-%m-%d %H:%M"), person: @helpers.care_person(event.edited_by)) if event.edited?)
    ]
  end

  def details(event)
    text = case event.kind
    when "fed"
      food = (I18n.t("trackers.food_types.#{event.details['food_type']}") if event.details["food_type"])
      [ food, @helpers.fed_details_text(event.details["brand"], event.details["description"], event.details["amount_g"]).presence ].compact.join(" · ")
    when "litter" then @helpers.litter_observations_text(event, with_cat: false)
    when "meds" then "#{@helpers.dose_name(event)}, #{@helpers.dose_outcome(event)}"
    end
    text.presence
  end
end
