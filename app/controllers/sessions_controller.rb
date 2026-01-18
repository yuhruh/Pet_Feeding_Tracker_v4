class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    user = User.find_by(email_address: params[:email_address])

    if user.present?
      if user.authenticate(params[:password])
        start_new_session_for user
        user.last_sign_in_at = user.current_sign_in_at
        user.current_sign_in_at = Time.current
        user.sign_in_count = user.sign_in_count.to_i + 1
        user.save(validate: false)

        if user.new_user?
          flash[:notice] = "Hello, #{Current.user.username.capitalize} 👋. This is your first time to sign in, please add a new cat first for further tracker."
          redirect_to new_pet_path
        else
          flash[:notice] = "Welcome back to Cat Feeding Tracker, #{Current.user.username.capitalize}"
          redirect_to pets_path
        end
      else
        redirect_to new_session_path, alert: "The password is not correct"
      end
    else
      redirect_to new_session_path, alert: "This email has not been signed up yet."
    end
  end

  def destroy
    terminate_session
    flash[:alert] = "You have been signed out."
    redirect_to new_session_path
  end
end
