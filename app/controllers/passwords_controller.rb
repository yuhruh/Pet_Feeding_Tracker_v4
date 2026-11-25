class PasswordsController < ApplicationController
  allow_unauthenticated_access
  # Each request sends an email, so limit both the sender and the inbox being mailed.
  # The same response is used whether or not the email has an account.
  rate_limit to: 5, within: 15.minutes, only: :create, with: -> { redirect_to new_password_url, alert: t("passwords.create.alert_rate_limit") }
  rate_limit to: 3, within: 1.hour, only: :create, name: "per_email", by: -> { requested_email },
             with: -> { redirect_to new_password_url, alert: t("passwords.create.alert_rate_limit") }
  before_action :set_user_by_token, only: %i[ edit update ]

  def new
  end

  def create
    # The same one email the limit above counts: a list of emails finds nobody.
    if requested_email.present? && (user = User.find_by(email_address: requested_email))
      PasswordsMailer.reset(user).deliver_later
    end

    redirect_to new_session_path, notice: t(".notice")
  end

  def edit
  end

  def update
    # A blank password would otherwise "succeed" without changing anything.
    if params[:password].present? && @user.update(params.permit(:password, :password_confirmation))
      # Whoever knew the old password may still be signed in somewhere.
      @user.sessions.destroy_all
      # The reset link came by email, so the address is the person's. If it
      # wasn't confirmed before, whoever opened the account may not have been
      # them: everything that account gave access to goes.
      unconfirmed = !@user.email_confirmed?
      @user.confirm_email!
      household_notice = unconfirmed ? revoke_household_access : cancel_household_offers
      redirect_to new_session_path, notice: [ disconnect_linked_sign_ins, household_notice ].compact.join(" ")
    else
      @user.errors.add(:password, :blank) if params[:password].blank?
      redirect_to edit_password_path(params[:token]), alert: @user.errors.full_messages.to_sentence
    end
  end

  private
    def requested_email
      email = params[:email_address]
      email.is_a?(String) ? User.normalize_value_for(:email_address, email) : ""
    end

    # Whoever opened the account before may have offered its household to their
    # own second account, or invited one: those offers go. People already in the
    # household stay (a real owner who forgot the password needs them), and the
    # notice points to where they are listed.
    def revoke_household_access
      household = @user.owned_household
      return unless household

      household.ownership_transfers.pending.update_all(cancelled_at: Time.current)
      household.invitations.pending.update_all(expires_at: Time.current)
      household.viewer_links.active.find_each(&:revoke!)
      household.memberships.destroy_all
      household.pets.find_each(&:stop_sharing!)
      t(".household_revoked")
    end

    def cancel_household_offers
      household = @user.owned_household
      return unless household

      household.ownership_transfers.pending.update_all(cancelled_at: Time.current)
      household.invitations.pending.update_all(expires_at: Time.current)
      t(".household_reviewed") if household.memberships.exists? || household.viewer_links.active.exists?
    end
    # Sign-up doesn't prove the email is yours, so someone else may have opened
    # this account and linked their own Google, LINE or GitHub to it. The reset
    # link does prove it: from here on only the new password signs in, and a
    # provider sign-in that is on its way to the app is dropped too.
    def disconnect_linked_sign_ins
      @user.native_sign_ins.delete_all
      providers = @user.connected_services.destroy_all.map(&:provider).uniq
      return t(".notice") if providers.empty?

      t(".notice_disconnected", providers: providers.map { |provider| ConnectedService.provider_name(provider) }.to_sentence)
    end

    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: t(".alert")
    end
end
