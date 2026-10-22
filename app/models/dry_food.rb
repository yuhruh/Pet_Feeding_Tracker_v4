class DryFood < ApplicationRecord
  # A food bag belongs to a household, shared by its cats.
  belongs_to :household
  has_many :trackers, dependent: :nullify

  enum :food_type, { kibble: "Kibble", freeze_dried: "Freeze-Dried" }

  # Food bags in the household the user owns.
  scope :owned_by, ->(user) { where(household_id: Household.where(owner_id: user.id).select(:id)) }

  before_create :set_left_amount

  def brand_with_description
    "#{brand} - #{description}"
  end

  # Leftovers stay in the bowl and the next feeding only tops the bowl up, so a
  # feeding takes from the bag just what the cat ate before the next one. Each
  # cat's newest feeding is still in the bowl, so it counts in full, as does a
  # feeding whose leftover was never recorded or was thrown away.
  def update_used_amount!
    with_lock do
      feedings = Tracker.where(dry_food_id: id, archived_dry_food: false).to_a
      offset = Tracker.feed_time_offset(household.owner&.timezone)
      newest_ids = feedings.group_by(&:pet_id).values.map { |pet_feedings| pet_feedings.max_by { |t| feeding_order(t, offset) }.id }
      drawn = feedings.to_h { |t| [ t, newest_ids.include?(t.id) || t.left_amount.nil? || t.leftover_discarded? ? t.amount : t.amount - t.left_amount ] }
      total_poured = drawn.values.sum

      Rails.logger.info "[DryFood Inventory] Bag ID: #{id} | Total Trackers: #{feedings.size}"
      Rails.logger.info "[DryFood Inventory] Drawn Amounts: #{drawn.values}"
      Rails.logger.info "[DryFood Inventory] Calculated Sum: #{total_poured}"

      daily_sums = drawn.group_by { |t, _| t.date }.values.map { |day| day.sum { |_, grams| grams } }
      avg_daily = daily_sums.any? ? (daily_sums.sum.to_f / daily_sums.size).round(2) : 0
      remaining = [ amount - total_poured, 0 ].max
      days_left = avg_daily > 0 ? (remaining / avg_daily).to_i : 0
      end_date = avg_daily > 0 ? Date.current + days_left.days : nil

      update_columns(
        total_ate_amount: total_poured,
        left_amount: remaining,
        average_used_amount: avg_daily,
        days_remaining: end_date
      )
    end
  end

  private

  # Date, then time of day on the owner's clock (feed_time is stored in UTC), then id.
  def feeding_order(tracker, offset)
    seconds = tracker.feed_time ? (tracker.feed_time.utc.seconds_since_midnight + offset) % 1.day : 0
    [ tracker.date || Date.new(0), seconds, tracker.id ]
  end

  def set_left_amount
    self.left_amount = amount
  end
end
