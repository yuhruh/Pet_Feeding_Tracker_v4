# One piece of care, recorded with one tap: a cat fed or weighed, a litter box
# scooped, a water spot refilled. The household always comes from the cat or spot,
# never from the form, and every save checks that nothing crosses households.
class CareEvent < ApplicationRecord
  include RefreshesHouseholdPages

  UNDO_WINDOW = 10.seconds
  EDIT_WINDOW = 24.hours
  EARLIEST = 7.days
  CLOCK_DRIFT = 2.minutes
  # A second water tap on the same spot within this time adds to the open record.
  WATER_MERGE_WINDOW = 2.minutes
  # "Mom fed Aji at 08:05; record again?" within these times.
  # Litter is often scooped several times a day (checkpoint H2), so 30 minutes too.
  REPEAT_WINDOWS = { "fed" => 30.minutes, "water" => 30.minutes, "litter" => 30.minutes }.freeze

  SPOT_ACTIONS = {
    "litter_box" => %w[scooped full_change],
    "water_bowl" => %w[refilled cleaned],
    "water_fountain" => %w[refilled cleaned filter_changed]
  }.freeze
  FOOD_TYPES = %w[kibble freeze_dried wet other].freeze
  FED_DETAILS = %w[food_type brand description amount_g dry_food_id].freeze
  # A one-off medicine that isn't one of the cat's medications.
  MEDS_DETAILS = %w[medicine_name medicine_dose].freeze
  # Litter observations, all optional (checkpoint F); "which cat" is the pet.
  LITTER_DETAILS = %w[pee poop_count stool unusual].freeze
  DETAILS = { "fed" => FED_DETAILS, "meds" => MEDS_DETAILS, "litter" => LITTER_DETAILS }.freeze
  PEE = %w[none few normal many].freeze
  STOOL = %w[normal soft diarrhea hard].freeze
  UNUSUAL = %w[blood large_clumps other].freeze
  MAX_POOPS = 10
  DOSE_STATUSES = %w[given couldnt_give].freeze
  REASONS = %w[refused spat_out vomited other].freeze
  # An as-needed or one-off medicine given within this time asks before another dose.
  MEDS_REPEAT_WINDOW = 2.hours

  belongs_to :household
  belongs_to :actor, class_name: "User", optional: true
  belongs_to :edited_by, class_name: "User", optional: true
  belongs_to :deleted_by, class_name: "User", optional: true
  belongs_to :pet, optional: true
  belongs_to :care_spot, optional: true
  belongs_to :tracker, optional: true
  belongs_to :medication, optional: true

  enum :kind, { fed: "fed", weight: "weight", litter: "litter", water: "water", meds: "meds" }, validate: true

  scope :kept, -> { where(undone_at: nil) }
  scope :between, ->(range) { where(occurred_at: range) }

  before_validation :take_household_from_subject
  before_validation :tidy_details

  validates :occurred_at, presence: true
  validate :subject_fits_kind, :same_household, :actions_fit_spot, :occurred_in_allowed_range,
           :fed_details_valid, :litter_details_valid, :weight_valid, :meds_valid

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

  # The box or spot for litter and water (a litter record may also name a cat).
  def subject = care_spot || pet

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

  # Delete (checkpoint H3): the same people as Change, for records up to 7 days old.
  def deletable_by?(user, now: Time.current)
    !undone? && editable_by?(user, now: now) && occurred_at >= now - EARLIEST
  end

  def deleted? = deleted_by_id.present?

  # Hidden like an undone tap, with who deleted it. A feeding added to trackers
  # is unlinked, so the owner's tracker shows on the timeline on its own.
  def delete_by!(user)
    update_columns(undone_at: Time.current, deleted_by_id: user.id, tracker_id: nil, updated_at: Time.current)
    refresh_household_pages
  end

  # The same care recorded shortly before, by anyone, if there is one.
  def recent_repeat
    return recent_dose if meds?

    window = REPEAT_WINDOWS[kind] or return
    scope = CareEvent.kept.where(kind: kind).where(occurred_at: (occurred_at - window)..(occurred_at + window))
    scope = care_spot ? scope.where(care_spot: care_spot) : scope.where(pet: pet)
    # Litter: only the same job counts (a full change soon after scooping is normal).
    scope.where.not(id: id).order(occurred_at: :desc).find { |event| !litter? || event.actions.intersect?(actions) }
  end

  def available_actions = SPOT_ACTIONS.fetch(care_spot&.kind.to_s, [])

  # The same dose already given: today's dose at this time, or an as-needed or
  # one-off medicine given within the last 2 hours.
  def recent_dose
    return unless given?

    scope = CareEvent.kept.meds.where(pet: pet, dose_status: "given").where.not(id: id)
    if medication && dose_time
      day = occurred_at.in_time_zone(pet.household.time_zone).all_day
      scope.where(medication: medication, dose_time: dose_time, occurred_at: day).order(occurred_at: :desc).first
    else
      scope = scope.where(occurred_at: (occurred_at - MEDS_REPEAT_WINDOW)..(occurred_at + MEDS_REPEAT_WINDOW))
      scope = medication ? scope.where(medication: medication) : scope.where(medication: nil)
      scope.order(occurred_at: :desc).find { |event| medication || event.details["medicine_name"] == details["medicine_name"] }
    end
  end

  def given? = dose_status == "given"

  def observations? = litter? && (pet_id.present? || details.any?)

  # Diarrhea or anything unusual stands out on the timeline and the cat's history.
  def observation_warning? = litter? && (details["stool"] == "diarrhea" || details["unusual"].present?)

  # "Clavamox 1 tablet", or the one-off medicine's name and dose.
  def medicine_label
    medication ? medication.label : details.values_at("medicine_name", "medicine_dose").compact_blank.join(" ")
  end

  def undo!
    update_columns(undone_at: Time.current, updated_at: Time.current)
    refresh_household_pages
  end

  private

  def take_household_from_subject
    self.household = subject.household if subject
  end

  def tidy_details
    self.actions = Array(actions).map(&:to_s).compact_blank.uniq
    # Always in the spot's order: "refilled, fountain cleaned".
    self.actions = actions.sort_by { |action| available_actions.index(action) || available_actions.size }
    cleaned = (details || {}).to_h.stringify_keys.slice(*DETAILS.values.flatten)
    cleaned["unusual"] = Array(cleaned["unusual"]).map(&:to_s).compact_blank.uniq.sort_by { |item| UNUSUAL.index(item) || UNUSUAL.size } if cleaned.key?("unusual")
    cleaned = cleaned.compact_blank
    cleaned["poop_count"] = cleaned["poop_count"].to_i if cleaned["poop_count"].to_s.match?(/\A\d+\z/)
    self.details = cleaned
    self.reason = nil unless dose_status == "couldnt_give"
  end

  def subject_fits_kind
    if fed? || weight? || meds?
      errors.add(:pet, :blank) unless pet && care_spot.nil?
    elsif litter? || water?
      errors.add(:care_spot, :blank) unless care_spot
      # Only a litter observation names a cat.
      errors.add(:pet, :present) if water? && pet
      errors.add(:care_spot, :invalid) if care_spot && care_spot.litter_box? != litter?
    end
  end

  def same_household
    return unless household_id && subject

    errors.add(:household, :invalid) unless subject.household_id == household_id
    errors.add(:pet, :other_household) if pet && pet.household_id != household_id
    if details["dry_food_id"].present? && !household.dry_foods.exists?(id: details["dry_food_id"])
      errors.add(:details, :other_household_bag)
    end
    errors.add(:tracker, :invalid) if tracker && tracker.pet_id != pet_id
    errors.add(:medication, :other_cat) if medication && medication.pet_id != pet_id
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
    return errors.add(:details, :present) unless (details.keys - DETAILS.fetch(kind.to_s, [])).empty?
    return unless fed?

    errors.add(:details, :food_type) if details["food_type"] && !FOOD_TYPES.include?(details["food_type"])
    amount = details["amount_g"]
    errors.add(:details, :amount) if amount && !(amount.to_s.match?(/\A\d+(\.\d+)?\z/) && amount.to_f.between?(0.1, 2000))
    %w[brand description].each { |key| errors.add(:details, :too_long) if details[key].to_s.length > 100 }
  end

  def litter_details_valid
    return unless litter?

    errors.add(:details, :pee) if details["pee"] && !PEE.include?(details["pee"])
    errors.add(:details, :stool) if details["stool"] && !STOOL.include?(details["stool"])
    errors.add(:details, :unusual) if details["unusual"] && !(details["unusual"] - UNUSUAL).empty?
    count = details["poop_count"]
    errors.add(:details, :poop_count) if count && !(count.to_s.match?(/\A\d+\z/) && count.to_i <= MAX_POOPS)
  end

  def meds_valid
    unless meds?
      errors.add(:medication, :present) if medication_id || dose_status || dose_time
      return
    end

    errors.add(:dose_status, :inclusion) unless DOSE_STATUSES.include?(dose_status)
    errors.add(:reason, :inclusion) if dose_status == "couldnt_give" && !REASONS.include?(reason)
    if medication
      errors.add(:dose_time, :inclusion) if dose_time && !medication.times.include?(dose_time)
    else
      errors.add(:dose_time, :present) if dose_time
      errors.add(:details, :medicine_name) if details["medicine_name"].blank?
    end
    %w[medicine_name medicine_dose].each { |key| errors.add(:details, :too_long) if details[key].to_s.length > 60 }
  end

  def weight_valid
    if weight?
      errors.add(:value, :weight_range) unless value && value.between?(0.1, 30)
    elsif value.present?
      errors.add(:value, :present)
    end
  end
end
