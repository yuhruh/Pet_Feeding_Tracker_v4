# The link in the confirmation email (show), and "Send the link again" on the
# profile page (create). See User#email_confirmed?.
class EmailConfirmationsController < ApplicationController
  allow_unauthenticated_access only: :show
  rate_limit to: 3, within: 1.hour, only: :create, by: -> { Current.user.id },
             with: -> { redirect_to users_path, alert: t("email_confirmations.create.rate_limited") }

  # The link may be opened on another device, signed out: it confirms the
  # address and signs nobody in.
  def show
    user = User.find_by_token_for(:email_confirmation, params[:token])
    destination = authenticated? ? users_path : new_session_path
    if user
      user.confirm_email!
      redirect_to destination, notice: t(".confirmed", email: user.email_address)
    else
      redirect_to destination, alert: t(".invalid")
    end
  end

  def create
    if Current.user.email_confirmed?
      redirect_to users_path, notice: t(".already_confirmed")
    else
      UserMailer.with(user: Current.user, locale: I18n.locale.to_s).email_confirmation.deliver_later
      redirect_to users_path, notice: t(".sent", email: Current.user.email_address)
    end
  end
end
