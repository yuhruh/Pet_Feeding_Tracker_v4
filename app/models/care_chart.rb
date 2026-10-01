# Care records per day for one cat's charts (checkpoint G): the household's
# litter and water jobs, and the cat's own tapped feedings, doses and litter
# observations, plus its ⚖️ weights for the weight line. Days are the household's.
class CareChart
  SERIES = %w[fed litter water given not_given observations].freeze
  COLORS = %w[#F59E0B #A16207 #0EA5E9 #16A34A #DC2626 #7C3AED].freeze

  attr_reader :pet, :zone

  # Dates are inclusive; nil means no limit on that side.
  def initialize(pet, from: nil, to: nil)
    @pet = pet
    @zone = pet.household.time_zone
    @from = from
    @to = to
  end

  def any? = counts.values.any?(&:present?)

  # { "fed" => { Date => 2 }, "litter" => { Date => 3 }, ... }
  def counts
    @counts ||= begin
      counts = SERIES.index_with { Hash.new(0) }
      events.each do |event|
        date = local_date(event.occurred_at)
        SERIES.each { |key| counts[key][date] += 1 if counts?(key, event) }
      end
      counts.transform_values { |by_date| by_date.reject { |_, count| count.zero? } }
    end
  end

  def dates = counts.values.flat_map(&:keys).uniq.sort

  # Chartkick series over every day with care, so the days line up.
  def series
    SERIES.map do |key|
      { name: I18n.t("care_chart.series.#{key}"), data: dates.to_h { |date| [ date.strftime("%y/%m/%d"), counts[key].fetch(date, 0) ] } }
    end
  end

  # [[Date, kg], ...] from the cat's ⚖️ records.
  def weights
    pet.care_events.kept.weight.where(occurred_at: time_range).pluck(:occurred_at, :value).map { |at, kg| [ local_date(at), kg.to_f ] }
  end

  private

  def events
    pet.household.care_events.kept.where(occurred_at: time_range)
       .where("care_events.pet_id = ? OR care_events.kind IN (?)", pet.id, %w[litter water]).to_a
  end

  def counts?(key, event)
    case key
    when "fed" then event.fed? && event.pet_id == pet.id
    when "litter", "water" then event.kind == key
    when "given" then event.meds? && event.pet_id == pet.id && event.given?
    when "not_given" then event.meds? && event.pet_id == pet.id && !event.given?
    when "observations" then event.litter? && event.pet_id == pet.id
    end
  end

  def time_range
    start = @from && zone.local(@from.year, @from.month, @from.day)
    finish = @to && zone.local(@to.year, @to.month, @to.day).end_of_day
    start..finish
  end

  def local_date(time) = time.in_time_zone(zone).to_date
end
