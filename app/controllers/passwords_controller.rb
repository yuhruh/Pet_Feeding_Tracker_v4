class PasswordsController < ApplicationController
  allow_unauthenticated_access
  # Each request sends an email, so limit both the sender and the inbox being mailed.
  # The same response is used whether or not the email has an account.
  rate_limit to: 5, within: 15.minutes, only: :create, with: -> { redirect_to new_password_url, alert: t("passwords.create.alert_rate_limit") }
  rate_limit to: 3, within: 1.hour, only: :create, name: "per_email", by: -> { params[:email_address].to_s.strip.downcase },
             with: -> { redirect_to new_password_url, alert: t("passwords.create.alert_rate_limit") }
  before_action :set_user_by_token, only: %i[ edit update ]

  def new
  end

  def create
    if user = User.find_by(email_address: params[:email_address])
      PasswordsMailer.reset(user).deliver_later
    end

    redirect_to new_session_path, notice: t(".notice")
  end

  def edit
  end

  def update
    # A blank password would otherwise "succeed" without changing anything.
    if params[:password].present? && @user.update(params.permit(:password, :password_confirmation))
      redirect_to new_session_path, notice: t(".notice")
    else
      @user.errors.add(:password, :blank) if params[:password].blank?
      redirect_to edit_password_path(params[:token]), alert: @user.errors.full_messages.to_sentence
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: t(".alert")
    end
end
