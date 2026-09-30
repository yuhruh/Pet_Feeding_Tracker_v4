# What happens when someone signs in or signs up: an invitation they opened first
# is accepted, and they land where their households say (see the plan's "Where
# people land after signing in").
module HouseholdArrival
  extend ActiveSupport::Concern

  private

  # Accepts the invitation kept in the session by the join page, if any. Returns
  # the flash for the redirect ({ notice: } or { alert: }), or nil.
  def claim_household_invitation(user)
    token = session.delete(:invitation_token)
    invitation = HouseholdInvitation.find_by_token(token) if token
    return unless invitation

    if invitation.accept!(user)
      { notice: t("household_joins.joined", household: helpers.household_name(invitation.household)) }
    else
      { alert: invitation.errors.map(&:message).to_sentence }
    end
  end

  # Anyone in someone else's household lands on Today, even on their first sign-in;
  # a new user with no household adds a cat; everyone else gets their pet list.
  def landing_path_for(user)
    if user.household_memberships.exists?
      today_path
    elsif user.new_user?
      new_pet_path
    else
      pets_path
    end
  end
end
