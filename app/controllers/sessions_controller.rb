class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

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
          redirect_to new_pet_path, notice: "Hello, #{Current.user.username.capitalize} 👋. This is your first time to sign in, please add a new cat first for further tracker."
        else
          redirect_to pets_path, notice: "Welcome back to Cat Feeding Tracker, #{Current.user.username.capitalize}"
        end
      else
        msg = if @user.connected_services.any?
                "You've previously signed in using your #{connected_services_string(@user)} account. Please use that to sign in."
        else
                "The password is not correct"
        end
        redirect_to new_session_path, alert: msg, status: :see_other
      end
    else
      # @user = User.new(email_address: params[:email_address])
      # flash.now[:alert] = "This email has not been signed up yet. Please sign up first"
      # render "registrations/new", status: :unprocessable_entity
      redirect_to new_registrations_path, alert: "This email has not been signed up yet. Please sign up first", status: :see_other, allow_other_host: true
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, alert: "You have been signed out.", status: :see_other
  end

  private
  def connected_services_string(user)
    user.connected_services.map(&:provider).to_sentence(last_word_connector: " or")
  end
end
