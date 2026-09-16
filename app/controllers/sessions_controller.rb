class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 5.minutes, only: :create, with: -> { redirect_to new_session_url, alert: t("sessions.create.alert_rate_limit") }

  def new
    session[:init] = true
  end

  def create
    # authenticate_by hashes the password even when no account has this email, so the
    # response time doesn't reveal which emails are registered. to_s keeps a crafted
    # request from sending a list of emails or leaving the password out.
    if (@user = User.authenticate_by(email_address: params[:email_address].to_s, password: params[:password].to_s))
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
      # One message for an unknown email and a wrong password, and no provider names,
      # so the sign-in form can't be used to find out who has an account. The form is
      # shown again rather than redirected, so the email the user typed stays visible.
      @sign_in_failed = true
      flash.now[:alert] = t(".alert_invalid_credentials")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, alert: t(".alert"), status: :see_other
  end

  def destroy_others
    Current.user.sessions.where.not(id: Current.session.id).destroy_all
    redirect_to users_path, notice: t(".notice"), status: :see_other
  end
end
