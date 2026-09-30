class DryFood < ApplicationRecord
  belongs_to :user
  # Until dry_foods.user_id is removed, a bag's household is its owner's household.
  belongs_to :household
  has_many :trackers, dependent: :nullify
  before_validation :join_owners_household, if: -> { household_id.nil? && user }
  validate :household_owned_by_user

  enum :food_type, { kibble: "Kibble", freeze_dried: "Freeze-Dried" }

  # Food bags in the household the user owns.
  scope :owned_by, ->(user) { where(household_id: Household.where(owner_id: user.id).select(:id)) }

  before_create :set_left_amount

  def brand_with_description
    "#{brand} - #{description}"
  end

  def update_used_amount!
    with_lock do
      relevant_trackers = Tracker.where(dry_food_id: id, archived_dry_food: false)
      total_poured = relevant_trackers.sum(:amount)

      Rails.logger.info "[DryFood Inventory] Bag ID: #{id} | Total Trackers: #{relevant_trackers.count}"
      Rails.logger.info "[DryFood Inventory] Individual Amounts: #{relevant_trackers.pluck(:amount)}"
      Rails.logger.info "[DryFood Inventory] Calculated Sum: #{total_poured}"
      Rails.logger.info "current_date: #{Date.current}"

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

  def join_owners_household
    self.household = Household.for_owner(user)
  end

  def household_owned_by_user
    errors.add(:household, :invalid) if household && user_id && household.owner_id != user_id
  end

  def set_left_amount
    self.left_amount = amount
  end
end
