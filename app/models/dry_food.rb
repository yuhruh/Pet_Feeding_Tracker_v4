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
      total_consumed = trackers.sum(:amount)
      daily_sums = trackers.group(:date).sum(:amount).values
      avg_daily = daily_sums.any? ? (daily_sums.sum.to_f / daily_sums.size).round(2) : 0
      remaining = [ amount - total_consumed, 0 ].max
      days_left = avg_daily > 0 ? (remaining / avg_daily).to_i : 0
      end_date = avg_daily > 0 ? Time.current + days_left.days : nil
      update_columns(
        total_ate_amount: total_consumed,
        used_amount: amount,
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
