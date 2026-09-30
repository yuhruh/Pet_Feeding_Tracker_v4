# One piece of care, recorded with one tap: a cat fed or weighed, a litter box
# scooped, a water spot refilled. The household always comes from the cat or spot,
# never from the form, and every save checks that nothing crosses households.
class CareEvent < ApplicationRecord
  UNDO_WINDOW = 10.seconds
  EDIT_WINDOW = 24.hours
  EARLIEST = 7.days
  CLOCK_DRIFT = 2.minutes
  # A second water tap on the same spot within this time adds to the open record.
  WATER_MERGE_WINDOW = 2.minutes
  # "Mom fed Aji at 08:05; record again?" within these times.
  REPEAT_WINDOWS = { "fed" => 30.minutes, "water" => 30.minutes, "litter" => 2.hours }.freeze

  SPOT_ACTIONS = {
    "litter_box" => %w[scooped full_change],
    "water_bowl" => %w[refilled cleaned],
    "water_fountain" => %w[refilled cleaned filter_changed]
  }.freeze
  FOOD_TYPES = %w[kibble freeze_dried wet other].freeze
  FED_DETAILS = %w[food_type brand description amount_g dry_food_id].freeze

  belongs_to :household
  belongs_to :actor, class_name: "User", optional: true
  belongs_to :edited_by, class_name: "User", optional: true
  belongs_to :pet, optional: true
  belongs_to :care_spot, optional: true
  belongs_to :tracker, optional: true

  enum :kind, { fed: "fed", weight: "weight", litter: "litter", water: "water" }, validate: true

  scope :kept, -> { where(undone_at: nil) }
  scope :between, ->(range) { where(occurred_at: range) }

  before_validation :take_household_from_subject
  before_validation :tidy_details

  validates :occurred_at, presence: true
  validate :subject_fits_kind, :same_household, :actions_fit_spot, :occurred_in_allowed_range,
           :fed_details_valid, :weight_valid

  # A cat or active care spot in one of the user's households; anything else is
  # "not found" (ActiveRecord::RecordNotFound).
  def self.subject_for(user, pet_id: nil, care_spot_id: nil)
    households = Household.reachable_by(user).select(:id)
    if pet_id.present?
      Pet.where(household_id: households).find(pet_id)
    else
      CareSpot.active.where(household_id: households).find(care_spot_id)
    end
  end

  def subject = pet || care_spot

  def undone? = undone_at.present?
  def edited? = edited_at.present?

  def undoable_by?(user, now: Time.current)
    user && actor_id == user.id && !undone? && created_at > now - UNDO_WINDOW
  end

  # The owner may change any record; a caregiver their own, for a day.
  def editable_by?(user, now: Time.current)
    policy = HouseholdPolicy.new(user, household)
    return true if policy.owner?

    policy.can?(:record_care) && actor_id == user.id && created_at > now - EDIT_WINDOW
  end

  # The same care recorded shortly before, by anyone, if there is one.
  def recent_repeat
    window = REPEAT_WINDOWS[kind] or return
    scope = CareEvent.kept.where(kind: kind).where(occurred_at: (occurred_at - window)..(occurred_at + window))
    scope = pet ? scope.where(pet: pet) : scope.where(care_spot: care_spot)
    # Litter: only the same job counts (a full change soon after scooping is normal).
    scope.where.not(id: id).order(occurred_at: :desc).find { |event| !litter? || event.actions.intersect?(actions) }
  end

  def available_actions = SPOT_ACTIONS.fetch(care_spot&.kind.to_s, [])

  def undo!
    update_columns(undone_at: Time.current, updated_at: Time.current)
  end

  private

  def take_household_from_subject
    self.household = subject.household if subject
  end

  def tidy_details
    self.actions = Array(actions).map(&:to_s).compact_blank.uniq
    self.details = (details || {}).to_h.stringify_keys.slice(*FED_DETAILS).compact_blank
  end

  def subject_fits_kind
    if fed? || weight?
      errors.add(:pet, :blank) unless pet && care_spot.nil?
    elsif litter? || water?
      errors.add(:care_spot, :blank) unless care_spot && pet.nil?
      errors.add(:care_spot, :invalid) if care_spot && care_spot.litter_box? != litter?
    end
  end

  def same_household
    return unless household_id && subject

    errors.add(:household, :invalid) unless subject.household_id == household_id
    if details["dry_food_id"].present? && !household.dry_foods.exists?(id: details["dry_food_id"])
      errors.add(:details, :other_household_bag)
    end
    errors.add(:tracker, :invalid) if tracker && tracker.pet_id != pet_id
  end

  def actions_fit_spot
    if litter? || water?
      errors.add(:actions, :blank) if actions.empty?
      errors.add(:actions, :inclusion) unless (actions - available_actions).empty?
    elsif actions.any?
      errors.add(:actions, :present)
    end
  end

  def occurred_in_allowed_range
    return unless occurred_at

    now = Time.current
    errors.add(:occurred_at, :in_the_future) if occurred_at > now + CLOCK_DRIFT
    errors.add(:occurred_at, :too_long_ago) if occurred_at < (created_at || now) - EARLIEST
  end

  def fed_details_valid
    return errors.add(:details, :present) if details.any? && !fed?
    return unless fed?

    errors.add(:details, :food_type) if details["food_type"] && !FOOD_TYPES.include?(details["food_type"])
    amount = details["amount_g"]
    errors.add(:details, :amount) if amount && !(amount.to_s.match?(/\A\d+(\.\d+)?\z/) && amount.to_f.between?(0.1, 2000))
    %w[brand description].each { |key| errors.add(:details, :too_long) if details[key].to_s.length > 100 }
  end

  def weight_valid
    if weight?
      errors.add(:value, :weight_range) unless value && value.between?(0.1, 30)
    elsif value.present?
      errors.add(:value, :present)
    end
  end
end
