# The owner invites a caregiver by email, or cancels a pending invitation.
class HouseholdInvitationsController < ApplicationController
  include OwnedHousehold

  rate_limit to: 20, within: 1.hour, only: :create, by: -> { Current.user.id },
             with: -> { redirect_to household_path, alert: t("household_invitations.create.rate_limited") }

  def create
    email = params[:email].to_s
    # A new invitation replaces an earlier one to the same address.
    @household.invitations.pending.where(email: email.strip.downcase).update_all(expires_at: Time.current)
    invitation = @household.invitations.new(email: email, invited_by: Current.user)

    if invitation.save
      HouseholdMailer.with(invitation: invitation, token: invitation.token, locale: I18n.locale.to_s).invitation.deliver_later
      redirect_to household_path, notice: t(".notice", email: invitation.email)
    else
      redirect_to household_path, alert: invitation.errors.map(&:message).to_sentence
    end
  end

  def destroy
    @household.invitations.pending.find(params[:id]).update!(expires_at: Time.current)
    redirect_to household_path, notice: t(".notice"), status: :see_other
  end
end
