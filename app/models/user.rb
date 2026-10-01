class User < ApplicationRecord
  has_secure_password
  has_many :connected_services, dependent: :destroy
  has_many :sessions, dependent: :destroy
  # The household of the user's own cats (nil until they add a pet or a food bag).
  has_one :owned_household, class_name: "Household", foreign_key: :owner_id, inverse_of: :owner, dependent: :destroy
  has_many :household_memberships, dependent: :destroy
  has_many :care_reminders, dependent: :delete_all
  # Links to other people's records, so deleting an account never blocks on them.
  has_many :sent_household_invitations, class_name: "HouseholdInvitation", foreign_key: :invited_by_id, dependent: :nullify
  has_many :accepted_household_invitations, class_name: "HouseholdInvitation", foreign_key: :accepted_by_id, dependent: :nullify
  has_many :created_viewer_links, class_name: "ViewerLink", foreign_key: :created_by_id, dependent: :nullify
  has_many :outgoing_ownership_transfers, class_name: "OwnershipTransfer", foreign_key: :from_user_id, dependent: :destroy
  has_many :incoming_ownership_transfers, class_name: "OwnershipTransfer", foreign_key: :to_user_id, dependent: :destroy
  has_many :pets, dependent: :destroy
  has_many :care_events, foreign_key: :actor_id, dependent: :nullify
  has_many :edited_care_events, class_name: "CareEvent", foreign_key: :edited_by_id, dependent: :nullify
  has_many :deleted_care_events, class_name: "CareEvent", foreign_key: :deleted_by_id, dependent: :nullify

  # The cats and food bags of the household the user owns (not ones they help with).
  def owned_pets = Pet.owned_by(self)
  def owned_dry_foods = DryFood.owned_by(self)

  # Households the user helps with (caregiver) or follows (viewer), not their own.
  def member_households = Household.where(id: household_memberships.select(:household_id))

  # Joined someone else's household and has no cats of their own: gets the smaller menu.
  def helper_only? = owned_household.nil? && household_memberships.exists?
  has_many :dry_foods, dependent: :destroy
  has_many :vet_visit_members, dependent: :destroy
  has_many :shared_vet_visits, through: :vet_visit_members, source: :vet_visit
  validates_associated :pets
  encrypts :gemini_api_key

  attr_accessor :email_address_confirmation

  validates :username, presence: true
  validates :email_address, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }, allow_nil: true
  validates :email_address, confirmation: true, on: :create
  MINIMUM_PASSWORD_LENGTH = 8

  # has_secure_password already requires a password on create and rejects ones
  # over 72 bytes (bcrypt's limit). A blank password on update keeps the current one.
  validates :password, length: { minimum: MINIMUM_PASSWORD_LENGTH }, allow_blank: true
  validates :password_confirmation, presence: true, if: -> { password.present? }, on: :update
  # A new password typed only in the confirmation box must not look like a successful change.
  validates :password, presence: true, if: -> { password_confirmation.present? }, on: :update
  validates :timezone, presence: true, on: :create
  validate :timezone_must_be_known, if: :will_save_change_to_timezone?

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def new_user?
    sign_in_count == 1
  end

  private

  # Only zones Rails can resolve: IANA names ("Asia/Taipei") or Rails names ("Taipei").
  def timezone_must_be_known
    return if timezone.blank? # presence is checked on create

    errors.add(:timezone, :invalid) unless ActiveSupport::TimeZone[timezone]
  end
end
