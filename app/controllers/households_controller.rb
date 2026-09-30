# The owner's household: who helps, pending invitations and viewer links.
class HouseholdsController < ApplicationController
  include OwnedHousehold

  def show
    @members = @household.memberships.includes(:user).order(:created_at)
    @invitations = @household.invitations.pending.order(:created_at)
    @viewer_links = @household.viewer_links.order(created_at: :desc)
    # Shown once, right after the link is made: only its digest is stored.
    @new_viewer_link_url = flash[:new_viewer_link_url]
  end
end
