class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]
  before_action :authenticated?, only: %i[edit update destroy]
  # Limits guessing the current password with a signed-in (possibly stolen) session.
  rate_limit to: 10, within: 5.minutes, only: :update, by: -> { Current.user.id },
             with: -> { redirect_to edit_users_path, alert: t("users.update.alert_rate_limit") }
  # Each new address gets a confirmation email.
  rate_limit to: 5, within: 1.day, only: :update, name: "email_change", by: -> { Current.user.id }, if: -> { changing_email? },
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
        # A new address is unconfirmed until its link is used (User#email_confirmed?).
        UserMailer.with(user: @user, locale: I18n.locale.to_s).email_confirmation.deliver_later if @user.saved_change_to_email_address?
        format.html { redirect_to users_path, notice: t(".update.notice") }
        format.json { render :show, status: :ok, location: users_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render_json_validation_errors(@user) }
      end
    end
  end

  def destroy
    # Someone else helps with these cats: offer the household to them first, unless
    # the owner chose to delete the household and its cats anyway.
    if @user.owned_household&.memberships&.exists? && params[:household] != "delete"
      return redirect_to household_path(anchor: "transfer"), alert: t("users.destroy.transfer_first"), status: :see_other
    end

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
    # Any text at all, even " ", is a new password: has_secure_password takes it.
    !params.dig(:user, :password).to_s.empty? || !params.dig(:user, :password_confirmation).to_s.empty? || changing_email?
  end

  def changing_email?
    new_email = params.dig(:user, :email_address)
    !new_email.nil? && User.normalize_value_for(:email_address, new_email.to_s) != Current.user.email_address
  end

  def user_params
    permitted = params.require(:user).permit(:username, :email_address, :password, :password_confirmation, :timezone, :gemini_api_key)
    # The form shows a stand-in for a saved Gemini key: unchanged means keep it, blank removes it.
    permitted.delete(:gemini_api_key) if permitted[:gemini_api_key] == User::SAVED_GEMINI_KEY_MASK
    permitted
  end
end
