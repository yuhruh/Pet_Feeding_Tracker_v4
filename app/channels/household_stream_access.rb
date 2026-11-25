# Live updates for a household's pages (Today, and the viewer link page) are
# only for people who may see that household now. The signed stream name in a
# page never expires, so on its own it would keep a revoked viewer link or a
# removed member listening. Prepended to Turbo::StreamsChannel (see
# config/initializers/household_stream_access.rb), because a client picks the
# channel itself; checked when subscribing and again every minute.
module HouseholdStreamAccess
  extend ActiveSupport::Concern

  RECHECK_EVERY = 1.minute

  prepended do
    periodically :stop_streams_without_access, every: RECHECK_EVERY
  end

  def subscribed
    return reject unless household_stream_allowed?

    super
  end

  private

  def stop_streams_without_access
    return if household_stream_allowed?

    stop_all_streams
    reject_subscription
  end

  # Streams that aren't a household's are left to Turbo's own check.
  def household_stream_allowed?
    # Turbo's stream name for one record is its GlobalID, base64-encoded.
    gid = GlobalID.parse(verified_stream_name_from_params.to_s)
    return true unless gid&.model_name == "Household"

    household = Household.find_by(id: gid.model_id)
    return false unless household

    user = connection.try(:current_user)
    return true if user && (household.owner_id == user.id || household.memberships.exists?(user_id: user.id))

    ViewerLink.find_active(viewer_link_token)&.household_id == household.id
  end

  def viewer_link_token
    (params[:viewer_link] || params[:viewerLink]).to_s
  end
end
