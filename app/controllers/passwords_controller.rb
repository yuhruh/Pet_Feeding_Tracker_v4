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
      # Whoever knew the old password may still be signed in somewhere.
      @user.sessions.destroy_all
      redirect_to new_session_path, notice: disconnect_linked_sign_ins
    else
      @user.errors.add(:password, :blank) if params[:password].blank?
      redirect_to edit_password_path(params[:token]), alert: @user.errors.full_messages.to_sentence
    end
  end

  private
    # Sign-up doesn't prove the email is yours, so someone else may have opened
    # this account and linked their own Google, LINE or GitHub to it. The reset
    # link does prove it: from here on only the new password signs in, and a
    # provider sign-in that is on its way to the app is dropped too.
    def disconnect_linked_sign_ins
      @user.native_sign_ins.delete_all
      providers = @user.connected_services.destroy_all.map(&:provider).uniq
      return t(".notice") if providers.empty?

      t(".notice_disconnected", providers: providers.map { |provider| ConnectedService.provider_name(provider) }.to_sentence)
    end

    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: t(".alert")
    end
end
