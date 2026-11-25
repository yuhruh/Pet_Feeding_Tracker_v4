class User < ApplicationRecord
  has_secure_password
  has_many :connected_services, dependent: :destroy
  has_many :sessions, dependent: :destroy
  # The household of the user's own cats (nil until they add a pet or a food bag).
  has_one :owned_household, class_name: "Household", foreign_key: :owner_id, inverse_of: :owner, dependent: :destroy
  has_many :household_memberships, dependent: :destroy
  has_many :care_reminders, dependent: :delete_all
  has_many :device_tokens, dependent: :delete_all
  has_many :native_sign_ins, dependent: :delete_all
  has_one :drive_backup, dependent: :destroy
  # Links to other people's records, so deleting an account never blocks on them.
  has_many :sent_household_invitations, class_name: "HouseholdInvitation", foreign_key: :invited_by_id, dependent: :nullify
  has_many :accepted_household_invitations, class_name: "HouseholdInvitation", foreign_key: :accepted_by_id, dependent: :nullify
  has_many :created_viewer_links, class_name: "ViewerLink", foreign_key: :created_by_id, dependent: :nullify
  has_many :outgoing_ownership_transfers, class_name: "OwnershipTransfer", foreign_key: :from_user_id, dependent: :destroy
  has_many :incoming_ownership_transfers, class_name: "OwnershipTransfer", foreign_key: :to_user_id, dependent: :destroy
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

  # How reminders (weight and household) reach this person. They choose one; until
  # they do, it's the Android app if a signed-in phone shows notifications (and
  # push is set up), else LINE if they signed in with LINE, else email. A failed
  # app or LINE send, or notifications turned off on the phone, goes by email instead.
  REMINDER_CHANNELS = %w[android line email].freeze
  REMINDER_PROBLEMS = %w[android_no_phone android_notifications_off android_failed line_not_connected line_failed].freeze
  validates :reminder_channel, inclusion: { in: REMINDER_CHANNELS }, allow_nil: true
  validates :reminder_problem, inclusion: { in: REMINDER_PROBLEMS }, allow_nil: true

  def reminder_channel_choice
    reminder_channel.presence ||
      if FcmClient.configured? && device_tokens.notifying.exists? then "android"
      elsif line_connected? then "line"
      else "email"
      end
  end

  def line_connected? = connected_services.any? { |service| service.provider == "line" }
  has_many :vet_visit_members, dependent: :destroy
  has_many :shared_vet_visits, through: :vet_visit_members, source: :vet_visit
  encrypts :gemini_api_key
  # What the profile form holds in place of a saved key, so the key itself never
  # goes back to the browser. Sent back unchanged, it means "keep the saved key".
  SAVED_GEMINI_KEY_MASK = "saved-key-not-shown".freeze

  attr_accessor :email_address_confirmation

  validates :username, presence: true
  # Names go into emails sent to other people (invitations), so keep them short.
  # Only checked when the name changes, so older long names still save.
  USERNAME_MAX_LENGTH = 50
  validates :username, length: { maximum: USERNAME_MAX_LENGTH }, if: :will_save_change_to_username?
  validates :email_address, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }, allow_nil: true
  validates :email_address, confirmation: true, on: :create
  MINIMUM_PASSWORD_LENGTH = 8

  # has_secure_password already requires a password on create and rejects ones
  # over 72 bytes (bcrypt's limit). A blank password on update keeps the current one.
  validates :password, length: { minimum: MINIMUM_PASSWORD_LENGTH }, allow_blank: true
  # " " is "blank" to Rails but still a password to has_secure_password: refuse it,
  # so spaces can't stand in for a real password or skip the minimum length.
  validate :password_not_only_spaces
  validates :password_confirmation, presence: true, if: -> { password.present? }, on: :update
  # A new password typed only in the confirmation box must not look like a successful change.
  validates :password, presence: true, if: -> { password_confirmation.present? }, on: :update
  validates :timezone, presence: true, on: :create
  validate :timezone_must_be_known, if: :will_save_change_to_timezone?

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # Sign-up doesn't prove the address is the person's (security scan F24), so a
  # password sign-up starts unconfirmed: until the link in the confirmation email
  # is used, the account can't share (invite, viewer links, share links, vet
  # visits) and can't be found by its address for a vet visit. Google, LINE and
  # GitHub sign-ups, an emailed invitation and a password reset prove it too.
  # The link stops working once the address changes; changing the address makes
  # the account unconfirmed again.
  EMAIL_CONFIRMATION_VALID_FOR = 3.days
  generates_token_for :email_confirmation, expires_in: EMAIL_CONFIRMATION_VALID_FOR do
    email_address
  end
  before_update -> { self.email_confirmed_at = nil }, if: :will_save_change_to_email_address?
  scope :email_confirmed, -> { where.not(email_confirmed_at: nil) }

  def email_confirmed? = email_confirmed_at.present?

  def confirm_email!
    update_column(:email_confirmed_at, Time.current) unless email_confirmed?
  end

  def password_not_only_spaces
    errors.add(:password, :blank) if password.is_a?(String) && !password.empty? && password.strip.empty?
  end
  private :password_not_only_spaces

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
