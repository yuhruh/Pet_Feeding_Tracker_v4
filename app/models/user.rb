class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  attr_accessor :email_address_confirmation

  validates :email_address, presence: true, 
                    uniqueness: { case_sensitive: false}, 
                    length: { maximum: 105 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }, allow_nil: true
  validates :email_address, confirmation: true, on: :create
  validates :password, presence: true, 
                    length: { maximum: 105 }
  validates :password_confirmation, presence: true
  validates :timezone, presence: true, on: :create

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def new_user?
    sign_in_count == 1
  end
end
