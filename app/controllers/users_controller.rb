class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]
  before_action :authenticated?, only: %i[edit update destroy]
  # Limits guessing the current password with a signed-in (possibly stolen) session.
  rate_limit to: 10, within: 5.minutes, only: :update, by: -> { Current.user.id },
             with: -> { redirect_to edit_users_path, alert: t("users.update.alert_rate_limit") }

  def edit
    @user = Current.user
  end

  def update
    # Changing the email or password needs the current password, so a stolen session
    # can't be turned into a permanent account takeover.
    if changing_sign_in_details? && !@user.authenticate(params.dig(:user, :current_password).to_s)
      @user.assign_attributes(user_params.except(:password, :password_confirmation))
      @user.errors.add(:current_password, t(".current_password_incorrect"))
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render_json_validation_errors(@user) }
      end
      return
    end

    respond_to do |format|
      if @user.update(user_params)
        # Whoever knew the old password may still be signed in on another device.
        @user.sessions.where.not(id: Current.session.id).destroy_all if @user.saved_change_to_password_digest?
        format.html { redirect_to users_path, notice: t(".update.notice") }
        format.json { render :show, status: :ok, location: users_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render_json_validation_errors(@user) }
      end
    end
  end

  def destroy
    @user.destroy!
    name = @user.username.split(" ").map(&:capitalize).join(" ")
    session[:user_id] = nil if @user == Current.user

    respond_to do |format|
      format.html { redirect_to "/home", status: :see_other, alert: t(".destroy.alert", name: name) }
      format.json { head :no_content }
    end
  end

  private
  def set_user
    @user = Current.user
  end

  def changing_sign_in_details?
    new_email = params.dig(:user, :email_address)
    params.dig(:user, :password).present? || params.dig(:user, :password_confirmation).present? ||
      (!new_email.nil? && User.normalize_value_for(:email_address, new_email.to_s) != @user.email_address)
  end

  def user_params
    params.require(:user).permit(:username, :email_address, :password, :password_confirmation, :timezone, :gemini_api_key)
  end
end
