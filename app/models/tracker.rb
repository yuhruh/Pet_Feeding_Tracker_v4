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



  private

  def dry_food?
    (kibble? || freeze_dried?) && dry_food.present?
  end

  def amount_less_than_dry_food_left_amount
    return unless amount.present? && dry_food

    dry_food.reload(lock: true)
    if dry_food.left_amount < amount
      errors.add(:amount, :greater_than_left_amount, left_amount: dry_food.left_amount)
    end
  end

  after_commit :update_dry_food_on_create, on: :create
  after_commit :update_dry_food_on_update, on: :update
  after_commit :update_dry_food_on_destroy, on: :destroy

  private

  def dry_food?
    (kibble? || freeze_dried?) && dry_food.present?
  end

  def amount_less_than_dry_food_left_amount
    return unless amount.present? && dry_food

    dry_food.reload(lock: true)
    if dry_food.left_amount < amount
      errors.add(:amount, :greater_than_left_amount, left_amount: dry_food.left_amount)
    end
  end

  def update_dry_food_on_create
    dry_food&.update_used_amount!
  end

  def update_dry_food_on_update
    # If the dry_food association changed, update the old one
    if previous_changes.key?(:dry_food_id)
      old_dry_food_id = previous_changes[:dry_food_id].first
      DryFood.find_by(id: old_dry_food_id)&.update_used_amount!
    end
    # Always update the new one (or the current one if it didn't change but other tracker attributes did)
    dry_food&.update_used_amount!
  end

  def update_dry_food_on_destroy
    # On destroy, the association is still available in memory
    dry_food&.update_used_amount!
  end

  def self.to_csv
    require "csv"
    CSV.generate(headers: true, col_sep: ";") do |csv|
      csv << [ "date", "feed_time", "come_back_to_eat", "food_type", "brand", "description", "amount", "left_amount", "total_ate_amount", "hungry", "love", "result", "note", "weight" ]
      find_each do |tracker|
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
