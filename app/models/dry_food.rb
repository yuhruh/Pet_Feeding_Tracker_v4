class DryFood < ApplicationRecord
  belongs_to :user
  has_many :trackers, dependent: :nullify

  enum :food_type, { kibble: "Kibble", freeze_dried: "Freeze-Dried" }

  before_create :set_left_amount

  def brand_with_description
    "#{brand} - #{description}"
  end

  def update_used_amount!
    with_lock do
      relevant_trackers = Tracker.where(dry_food_id: id)
      total_poured = relevant_trackers.sum(:amount)

      Rails.logger.info "[DryFood Inventory] Bag ID: #{id} | Total Trackers: #{relevant_trackers.count}"
      Rails.logger.info "[DryFood Inventory] Individual Amounts: #{relevant_trackers.pluck(:amount)}"
      Rails.logger.info "[DryFood Inventory] Calculated Sum: #{total_poured}"
      Rails.logger.info "current_date: #{set_current_date}"

      daily_sums = relevant_trackers.group(:date).sum(:amount).values
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

  def set_left_amount
    self.left_amount = amount
  end
end
