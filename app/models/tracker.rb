class Tracker < ApplicationRecord
  belongs_to :pet
  belongs_to :dry_food, optional: true
  before_save { self.brand = brand.downcase }
  before_save { self.description = description.downcase }

  enum :food_type, { kibble: "Kibble", freeze_dried: "Freeze-Dried", wet: "Wet", other: "Other" }
  HUNGRY_MAP = {
    eat_right_away: "💖 Yes, eat right away",
    ate_a_little: "🔺 No, not really. Ate A Little",
    not_interested: "❌ No, not interested"
  }
  enum :hungry, HUNGRY_MAP

  validates :food_type, presence: true
  validates :brand, presence: true, length: { minimum: 1, maximum: 50 }
  validates :description, presence: true, length: { minimum: 2, maximum: 100 }
  validates :amount, numericality: true, comparison: { greater_than: 0 }
  validates :left_amount, numericality: true, comparison: { less_than_or_equal_to: :amount }, on: :update, allow_nil: true
  validate :amount_less_than_dry_food_left_amount, if: :dry_food?

  after_commit :update_dry_food_used_amount, on: [ :create, :update, :destroy ]

  private

  def dry_food?
    (kibble? || freeze_dried?) && dry_food.present?
  end

  def amount_less_than_dry_food_left_amount
    if amount.present? && dry_food.left_amount < amount
      errors.add(:amount, :greater_than_left_amount, left_amount: dry_food.left_amount)
    end
  end

  def update_dry_food_used_amount
    return unless dry_food

    dry_food.with_lock do
      total_consumed = dry_food.trackers.sum(:amount)
      remaining_food = dry_food.amount - total_consumed

      daily_sums = dry_food.trackers.group(:date).sum(:amount).values

      if daily_sums.any?
        avg_daily_consumption = daily_sums.sum / daily_sums.size.to_f

        days_left = (remaining_food / avg_daily_consumption).to_i rescue 0
        expected_end_date = Time.current + days_left.days
      else
        avg_daily_consumption = 0
        expected_end_date = nil
      end

      dry_food.update_columns(
        total_ate_amount: total_consumed,
        left_amount: [ remaining_food, 0 ].max, # ensure don't show negative food
        average_used_amount: avg_daily_consumption.round(2),
        days_remaining: expected_end_date
      )
    end
  end

  def self.to_csv
    require "csv"
    CSV.generate(headers: true, col_sep: ";") do |csv|
      csv << [ "date", "feed_time", "come_back_to_eat", "food_type", "brand", "description", "amount", "left_amount", "total_ate_amount", "hungry", "love", "result", "note", "weight" ]
      all.each do |tracker|
        csv << [
          tracker.date,
          tracker.feed_time&.strftime("%H:%M"),
          tracker.come_back_to_eat,
          tracker.food_type,
          tracker.brand,
          tracker.description,
          tracker.amount,
          tracker.left_amount,
          tracker.total_ate_amount,
          HUNGRY_MAP[tracker.hungry.to_sym],
          tracker.love,
          tracker.result,
          tracker.note,
          tracker.weight
        ]
      end
    end
  end
end
