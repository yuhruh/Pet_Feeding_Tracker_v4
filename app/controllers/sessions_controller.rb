class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      user.last_sign_in_at = user.current_sign_in_at
      user.current_sign_in_at = Time.current
      user.sign_in_count = user.sign_in_count.to_t + 1
      user.save(validate: false)

      if user.new_uers?
        flash[:notice] = "Hello, #{Current.user.username.capitalize} 👋. This is your first time to sign in, please add a new cat first for further tracker."
        redirect_to after_authentication_url
      else
        start_new_session_for user
        flash[:notice] = "Welcome back to Cat Feeding Tracker, #{Current.user.username.capitalzie}"
        redirect_to users_path
      end
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    flash[:alert] = "You have been signed out."
    redirect_to new_session_path
  end
end
