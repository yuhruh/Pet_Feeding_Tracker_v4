class User < ApplicationRecord
  has_secure_password
  has_many :connected_services, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :pets, dependent: :destroy
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

  def self.from_omniauth(auth)
    # Find the connected account first
    connected_service = ConnectedService.find_by(provider: auth.provider, uid: auth.uid)

    # If the connected account exists, return its user
    return connected_service.user if connected_service

    # If no connected account, find or create the user by email
    user = User.find_or_initialize_by(email_address: auth.info.email)

    # If the user is new, set their details
    if user.new_record?
      user.name = auth.info.name       # Assuming you have a 'name' attribute
      user.password = SecureRandom.hex # Set a random password for OAuth users
      # You might want to skip email confirmation for OAuth users if you have that feature
    end

    # Associate the new provider with the user
    user.connected_services.build(provider: auth.provider, uid: auth.uid)

    user.save
    user
  end

  private

  # Only zones Rails can resolve: IANA names ("Asia/Taipei") or Rails names ("Taipei").
  def timezone_must_be_known
    return if timezone.blank? # presence is checked on create

    errors.add(:timezone, :invalid) unless ActiveSupport::TimeZone[timezone]
  end
end
