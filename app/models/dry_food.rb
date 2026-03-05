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
      current_trackers = trackers.reload
      total_poured = current_trackers.sum(:amount)
      total_poured_find = current_trackers.where(dry_food_id: id).sum(:amount)

      Rails.logger.info "[DryFood Inventory] Bag ID: #{id} | Total Trackers: #{current_trackers.count}"
      Rails.logger.info "[DryFood Inventory] Individual Amounts: #{current_trackers.pluck(:amount)}"
      Rails.logger.info "[DryFood Inventory] Calculated Sum: #{total_poured}"
      Rails.logger.info "[DryFood Inventory] Calculated Sum: #{total_poured_find}"


      daily_sums = trackers.group(:date).sum(:amount).values
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
