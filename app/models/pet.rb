class Pet < ApplicationRecord
  # How long a new share link works. nil means until it is turned off or replaced.
  SHARE_DURATIONS = { "never" => nil, "1_day" => 1.day, "7_days" => 7.days, "30_days" => 30.days }.freeze
  # How far back a kibble counts as a current favorite for the monthly price check.
  FAVORITE_KIBBLE_WINDOW = 4.months

  has_one_attached :pet_avatar
  belongs_to :user
  # Until pets.user_id is removed, a pet's household is its owner's household.
  belongs_to :household
  before_validation :join_owners_household, if: -> { household_id.nil? && user }
  validate :household_owned_by_user
  # The owner of the pet's household: the one person who manages it.
  delegate :owner, to: :household, allow_nil: true
  delegate :timezone, to: :owner, allow_nil: true
  has_many :care_events, dependent: :delete_all
  has_many :medications, dependent: :delete_all
  has_many :trackers, dependent: :destroy
  has_many :health_checks, dependent: :destroy
  has_many :vet_visits, dependent: :destroy
  has_many :kibble_price_checks, dependent: :destroy
  validates :petname, presence: true,
                      length: { minimum: 2, maximum: 25 }

  # Pets in households the user owns or is a member of (caregiver or viewer).
  scope :accessible_by, ->(user) {
    where(household_id: Household.where(owner_id: user.id).select(:id))
      .or(where(household_id: HouseholdMembership.where(user_id: user.id).select(:household_id)))
  }
  # Pets in the household the user owns.
  scope :owned_by, ->(user) { where(household_id: Household.where(owner_id: user.id).select(:id)) }

  # New pets are not shared until the owner turns on a share link.
  scope :shared, -> { where.not(share_token: nil).where("share_expires_at IS NULL OR share_expires_at > ?", Time.current) }

  def self.find_shared!(token)
    shared.find_by!(share_token: token.to_s)
  end

  def sharing?
    share_token.present? && !share_expired?
  end

  def share_expired?
    share_expires_at.present? && share_expires_at <= Time.current
  end

  # Creates a new link, so any earlier link stops working.
  def share!(expires_in: nil)
    update_columns(share_token: SecureRandom.urlsafe_base64(24), share_expires_at: expires_in&.from_now, updated_at: Time.current)
  end

  def stop_sharing!
    update_columns(share_token: nil, share_expires_at: nil, updated_at: Time.current)
  end

  # Rated foods grouped by type, brand and description, each with its five best-scored
  # days (latest first), most loved first. food_type is a partial, case-insensitive match.
  def favorite_foods(food_type: nil)
    trackers = rated_trackers
    trackers = trackers.where(Tracker.arel_table[:food_type].matches("%#{food_type.strip}%")) if food_type.present?

    group_favorites(trackers).map { |key, group| favorite_summary(key, group) }
                             .sort_by { |f| f[:results].first[:favorite_score] }.reverse
  end

  # The kibbles this pet has loved lately, most loved first, each with the
  # dry-food bag it was last fed from (nil when none was recorded).
  def favorite_kibbles(min_score: 30, since: FAVORITE_KIBBLE_WINDOW.ago, limit: 5)
    trackers = rated_trackers.kibble.where(date: since.to_date..).includes(:dry_food)

    group_favorites(trackers).map { |key, group| favorite_summary(key, group).merge(dry_food: group.find(&:dry_food)&.dry_food) }
                             .select { |f| f[:results].first[:favorite_score] >= min_score }
                             .sort_by { |f| f[:results].first[:favorite_score] }.reverse
                             .first(limit)
  end

  private

  def join_owners_household
    self.household = Household.for_owner(user)
  end

  def household_owned_by_user
    errors.add(:household, :invalid) if household && user_id && household.owner_id != user_id
  end

  # Feedings with a hungry or love rating, latest first.
  def rated_trackers
    trackers.where.not(hungry: [ nil, "" ], love: [ nil, "" ]).order(date: :desc)
  end

  # A trailing count such as "x3" or "（x3）" does not make a different food.
  def group_favorites(trackers)
    trackers.group_by do |tracker|
      clean_description = tracker.description.to_s.gsub("（", "(").gsub("）", ")").gsub(/\s*[\(\s]*[xX×]\s*\d+[\)\s]*\z/, "").squish.downcase

      [ tracker.food_type.to_s.squish.downcase, tracker.brand.to_s.squish.downcase, clean_description ]
    end
  end

  def favorite_summary((food_type, brand, description), group_trackers)
    unique_daily_results = group_trackers.sort_by { |t| t.favorite_score }.reverse
                                         .uniq { |t| t.date }
    {
      food_type: food_type,
      brand: brand,
      description: description,
      count: group_trackers.size,
      results: unique_daily_results.first(5).sort_by { |t| t.date }.reverse.map do |t|
        {
          id: t.id,
          date: t.date.strftime("%Y/%m/%d"),
          result: t.result,
          favorite_score: t.favorite_score
        }
      end
    }
  end
end
