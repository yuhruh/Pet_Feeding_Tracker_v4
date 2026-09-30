# The page a viewer link opens: one household's cats and their charts, read-only,
# with no sign-in and no app menu. Signing in or up from it adds the household to
# the viewer's account (HouseholdArrival); the link keeps working either way.
class ViewerPagesController < ApplicationController
  include TrackersCalculable
  include HouseholdArrival

  allow_unauthenticated_access
  before_action :resume_session, :keep_the_link_private, :set_viewer_link

  RANGES = %w[all 7 30 120 180 YTD].freeze

  def show
    @link.record_use!

    @household = @link.household
    @pets = @household.pets.order(:petname).to_a
    @pet = @pets.find { |pet| pet.id.to_s == params[:pet_id].to_s } || @pets.first
    @range = params[:range].presence_in(RANGES) || "30"
    @following = authenticated? && (@household.owner_id == Current.user.id || @household.memberships.exists?(user: Current.user))
    return unless @pet

    Time.zone = @pet.timezone if @pet.timezone
    result = calculate_tracker_data(@pet, { range: @range }, nil)
    @data, @chart_interval = result[:chart_data], result[:chart_interval]
    @min_weight, @max_weight = result[:min_weight], result[:max_weight]
    @dry_properties, @wet_properties = result[:dry_properties], result[:wet_properties]
  end

  # "Sign up or sign in" from the page: the household is added to the account
  # after signing in (HouseholdArrival), or right away for someone signed in.
  def create
    if authenticated?
      redirect_to today_path, add_viewer_membership(Current.user, @link)
    else
      session[:viewer_link_token] = params[:token]
      redirect_to params[:then] == "sign_up" ? new_registrations_path : new_session_path
    end
  end

  private

  def set_viewer_link
    @link = ViewerLink.find_active(params[:token])
    return if @link

    session.delete(:viewer_link_token)
    render :inactive, status: :not_found
  end

  # Not indexed by search engines, and the token isn't sent on to other sites.
  def keep_the_link_private
    response.set_header("X-Robots-Tag", "noindex, nofollow")
    response.set_header("Referrer-Policy", "no-referrer")
  end
end
