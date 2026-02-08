class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 5.minutes, only: :create, with: -> { redirect_to new_session_url, alert: t("sessions.create.alert_rate_limit") }

  def new
  end

  def create
    @user = User.find_by(email_address: params[:email_address])

    if @user.present?
      if @user.authenticate(params[:password])
        start_new_session_for @user
        @user.update_columns(
          last_sign_in_at: @user.current_sign_in_at,
          current_sign_in_at: Time.current,
          sign_in_count: @user.sign_in_count.to_i + 1
        )

        if @user.new_user?
          redirect_to new_pet_path, notice: t(".notice_new_user", username: Current.user.username.capitalize)
        else
          redirect_to pets_path, notice: t(".notice_welcome_back", username: Current.user.username.capitalize)
        end
      else
        msg = if @user.connected_services.any?
                t(".alert_with_connected_services", services: connected_services_string(@user))
        else
                t(".alert_wrong_password")
        end
        redirect_to new_session_path, alert: msg, status: :see_other
      end
    else
      # @user = User.new(email_address: params[:email_address])
      # flash.now[:alert] = "This email has not been signed up yet. Please sign up first"
      # render "registrations/new", status: :unprocessable_entity
      redirect_to "/registrations/new", alert: t(".alert_unregistered_email"), status: :see_other
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, alert: t(".alert"), status: :see_other
  end

  private
  def connected_services_string(user)
    user.connected_services.map(&:provider).to_sentence(last_word_connector: " or")
  end
end
