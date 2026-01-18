class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.sign_in_count = 1
    if @user.save
      start_new_session_for @user
      UserMailer.with(user: @user).welcome.deliver_later
      redirect_to new_pet_path, notice: "Hello, #{Current.user.username.capitalize} 👋. You've successfully signed up to Cat Feeding Tracker App and
                                      this is your first time to sign in, please add a new cat first for further tracker.
                                      Welcome #{@user.username.capitalize}!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.expect(user: [ :username, :email_address, :email_address_confirmation, :password, :password_confirmation, :timezone ])
  end
end
