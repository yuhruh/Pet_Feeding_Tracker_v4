# Google, LINE and GitHub sign-in callbacks. A sign-in the Android app started
# (NativeSignInsController#start, checkpoint I2) ran in Chrome: Chrome isn't
# signed in; the result goes back to the app with a one-time code instead.
class OmniAuth::SessionsController < ApplicationController
  include HouseholdArrival
  allow_unauthenticated_access only: [ :create, :failure ]
  before_action :use_the_apps_language
  before_action :set_service, only: [ :create ]
  before_action :set_user, only: [ :create ]

  def create
    Rails.logger.debug "OmniAuth info: #{user_info.inspect}"
    if !@service.present?
      @service = @user.connected_services.create!(provider: user_info.provider, uid: user_info.uid)
    end

    if Current.user.present?
      arrival = claim_household_invitation(@user)
      redirect_to landing_path_for(@user), arrival || { notice: t("omni_auth.sessions.create.connected", provider: @service.provider.to_s.humanize) }
    else
      start_new_session_for @user unless native_sign_in?
      @user.last_sign_in_at = @user.current_sign_in_at
      @user.current_sign_in_at = Time.current
      @user.sign_in_count = @user.sign_in_count.to_i + 1
      @user.save(validate: false)

      greeting = @user.new_user? ? t("omni_auth.sessions.create.first_time_sign_in") : t("omni_auth.sessions.create.welcome_back", username: @user.username.capitalize)
      arrival = claim_household_invitation(@user)
      finish_sign_in landing_path_for(@user), arrival || { notice: greeting }, user: @user
    end
  end

  def failure
    alert = params[:message] == "access_denied" ? t("omni_auth.sessions.failure.cancelled") : t("omni_auth.sessions.failure.issue")
    finish_sign_in new_session_path, { alert: alert }
  end

  private

  # Started from the app within the last 10 minutes; an abandoned one doesn't
  # turn a later website sign-in in the same Chrome into an app sign-in.
  def native_sign_in?
    started_at = session[:native_sign_in].is_a?(Hash) && session[:native_sign_in]["started_at"].to_i
    started_at.present? && started_at > NativeSignIn::CONTEXT_LIFETIME.ago.to_i
  end

  def use_the_apps_language
    I18n.locale = session[:native_sign_in]["locale"] if native_sign_in? && I18n.available_locales.map(&:to_s).include?(session[:native_sign_in]["locale"])
  end

  # The website: redirect, signed in already if there's a user. The app: a
  # one-time code for the app's WebView, and Chrome stays signed out.
  def finish_sign_in(path, flash_values, user: nil)
    return redirect_to(path, flash_values) unless native_sign_in?

    session.delete(:native_sign_in)
    data = { "omniauth_auth" => session.delete("omniauth.auth") }
    code = NativeSignIn.issue!(user: user, path: path, flash: flash_values.stringify_keys, data: data)
    @app_url = "pettracker://sign-in?code=#{code}"
    render "native_sign_ins/return", layout: false
  end

  def user_info
    @user_info ||= request.env["omniauth.auth"]
  end

  def set_service
    @service = ConnectedService.find_by(provider: user_info.provider, uid: user_info.uid)
  end

  def set_user
    # The app's sign-in is about the person at the provider, not whoever this
    # Chrome is signed in to on the website (Custom Tabs share Chrome's cookies).
    user = resume_session.try(:user) unless native_sign_in?
    if user.present?
      @user = user
    elsif @service.present?
      @user = @service.user
    elsif User.find_by(email_address: user_info.dig(:info, :email)).present?
      service_methods = ConnectedService.where(user_id: User.find_by(email_address: user_info.dig(:info, :email))).pluck(:provider).map(&:to_s).join(", ")
      finish_sign_in(new_session_path, { notice: t("omni_auth.sessions.create.email_exists", service_methods: service_methods) }) and return
    else
      if user_info.dig(:info, :email).blank? && user_info.provider == "line"
        session["omniauth.auth"] = user_info.to_hash
        finish_sign_in(new_registrations_path, { notice: t("omni_auth.sessions.create.enter_email_line") }) and return
      elsif user_info.dig(:info, :email).blank?
        finish_sign_in(new_registrations_path, { alert: t("omni_auth.sessions.create.enter_email") }) and return
      else
        @user = create_user
        UserMailer.with(user: @user).welcome_email.deliver_later
      end
    end
  end

  def create_user
    email = user_info.dig(:info, :email)
    username = user_info.dig(:info, :name) || user_info.dig(:info, :email).split("@").first
    random_password = SecureRandom.hex(10)
    # user_timezone = session["omniauth.timezone"]
    user_timezone = request.env.dig("omniauth.params", "timezone") || session[:timezone]
    # binding.b

    User.create!(
      email_address: email,
      username: username,
      password: random_password,
      password_confirmation: random_password,
      timezone: user_timezone)
  end
end
