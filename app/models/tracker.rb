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
  validate :dry_food_belongs_to_pet_owner, if: :will_save_change_to_dry_food_id?


  after_commit :sync_dry_food_inventory, on: [ :create, :destroy ]

  # UTC offset, in seconds, that the app uses to display feed_time in this zone.
  # Rails stores time columns on 2000-01-01 and converts them with that date's
  # offset, so the same offset is used here. Unknown zones fall back to UTC.
  def self.feed_time_offset(timezone)
    zone = ActiveSupport::TimeZone[timezone.to_s] || ActiveSupport::TimeZone["UTC"]
    Time.utc(2000, 1, 1).in_time_zone(zone).utc_offset
  end

  # SQL for feed_time as the local time of day the app shows, for ordering.
  # feed_time is stored in UTC, so without this a 00:20 Taipei feed (16:20 UTC)
  # sorts after 09:25 (01:25 UTC). The shift wraps past midnight, and the offset
  # is an integer computed here, never text from the user.
  def self.local_feed_time_sql(timezone)
    offset = Integer(feed_time_offset(timezone))
    if connection_db_config.adapter.start_with?("sqlite")
      format("time(feed_time, '%+d seconds')", offset)
    else
      "(feed_time + INTERVAL '#{offset} seconds')"
    end
  end

  private

  # A tracker may only draw from a dry-food bag owned by the pet's owner.
  # Another user's bag gets the same error as a missing one.
  def dry_food_belongs_to_pet_owner
    return if dry_food_id.blank?

    errors.add(:dry_food_id, :invalid) unless DryFood.exists?(id: dry_food_id, user_id: pet&.user_id)
  end

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

  def sync_dry_food_inventory
    dry_food&.update_used_amount!

    if saved_change_to_dry_food_id?
      previous_bag_id = saved_changes[:dry_food_id].first

      if previous_bag_id.present?
        DryFood.find_by(id: previous_bag_id)&.update_used_amount!
      end
    end
  end


  # def update_dry_food_on_create
  #   dry_food&.update_used_amount!
  # end

  # def update_dry_food_on_destroy
  #   # On destroy, the association is still available in memory
  #   dry_food&.update_used_amount!
  # end

  def self.to_csv(collection = nil, timezone = "UTC")
    require "csv"
    records = collection || all
    CSV.generate(headers: true, col_sep: ";") do |csv|
      csv << [ "date", "feed_time", "come_back_to_eat", "food_type", "brand", "description", "amount", "left_amount", "total_ate_amount", "hungry", "love", "result", "note", "weight" ].map { |attr| human_attribute_name(attr) }
      records.each do |tracker|
        csv << [
          tracker.date,
          tracker.feed_time&.in_time_zone(timezone)&.strftime("%H:%M"),
          tracker.come_back_to_eat,
          I18n.t("trackers.food_types.#{tracker.food_type}"),
          tracker.brand,
          tracker.description,
          tracker.amount,
          tracker.left_amount,
          tracker.total_ate_amount,
          tracker.hungry.present? ? I18n.t("trackers.hungry_options.#{tracker.hungry}") : nil,
          tracker.love,
          tracker.result,
          tracker.note,
          tracker.weight
        ]
      end
    end
  end
end
