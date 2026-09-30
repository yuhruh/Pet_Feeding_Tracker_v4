# What happens when someone signs in or signs up: an invitation they opened first
# is accepted, and they land where their households say (see the plan's "Where
# people land after signing in").
module HouseholdArrival
  extend ActiveSupport::Concern

  private

  # Accepts the invitation kept in the session by the join page, or follows the
  # household of the viewer link opened before signing in. Returns the flash for
  # the redirect ({ notice: } or { alert: }), or nil.
  def claim_household_invitation(user)
    viewer_link = ViewerLink.find_active(session.delete(:viewer_link_token))
    token = session.delete(:invitation_token)
    invitation = HouseholdInvitation.find_by_token(token) if token
    return add_viewer_membership(user, viewer_link) if viewer_link && !invitation
    return unless invitation

    if invitation.accept!(user)
      { notice: t("household_joins.joined", household: helpers.household_name(invitation.household)) }
    else
      { alert: invitation.errors.map(&:message).to_sentence }
    end
  end

  # Adds the link's household to the user's account as a viewer. Someone who is
  # already its owner or a member keeps what they have.
  def add_viewer_membership(user, viewer_link)
    household = viewer_link.household
    unless household.owner_id == user.id
      household.memberships.create_with(role: :viewer).find_or_create_by!(user: user)
    end
    { notice: t("viewer_pages.following", household: helpers.household_name(household)) }
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
