class RegistrationsController < ApplicationController
  include HouseholdArrival
  allow_unauthenticated_access only: %i[new create]
  rate_limit to: 10, within: 1.hour, only: :create, with: -> { redirect_to new_registrations_url, alert: t("registrations.create.alert_rate_limit") }
  before_action :resume_session, only: %i[new create]

  def new
    session[:init] = true
    @user = User.new

    if (auth_data = pending_provider_identity)
      @linking_provider = auth_data["provider"]
      auth_info = auth_data["info"] || {}

      # Handle LINE-specific username structure
      if auth_data["provider"] == "line"
        # LINE typically provides displayName or name
        @user.username = auth_info["name"] ||
                        auth_info["displayName"] ||
                        "line_user_#{auth_data['uid']}"

        # Email might not be available for LINE without permission
        @user.email_address = auth_info["email"] if auth_info["email"].present?
      else
        # Handle other providers
        @user.username = auth_info["name"] || auth_info["email"]&.split("@")&.first
        @user.email_address = auth_info["email"]
      end
    end
  end

  def create
    @user = User.new(user_params)
    @user.sign_in_count = 1
    if @user.save
      if (auth_data = pending_provider_identity)
        @user.connected_services.create!(
          provider: auth_data["provider"],
          uid: auth_data["uid"]
        )
        forget_provider_identity
      end
      start_new_session_for @user
      # The typed address isn't proven yet: send the link that confirms it.
      UserMailer.with(user: @user, locale: I18n.locale.to_s).email_confirmation.deliver_later
      arrival = claim_household_invitation(@user)
      redirect_to landing_path_for(@user), arrival || { notice: [ t(".notice", username: @user.username.capitalize), t("email_confirmations.sent_at_sign_up", email: @user.email_address) ].join(" ") }
    else
      @linking_provider = pending_provider_identity&.dig("provider")
      flash[:alert] = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.expect(user: [ :username, :email_address, :email_address_confirmation, :password, :password_confirmation, :timezone ])
  end
end
