class SharedTrackersController < ApplicationController
  include TrackersCalculable

  # Allow public access to this specific view
  skip_before_action :require_authentication

  def show
    @pet = Pet.find_by!(share_token: params[:share_token])

    # Calculate data using the shared concern
    # Pass nil for user since this is public
    result = calculate_tracker_data(@pet, params, nil)

    @all_trackers = result[:all_trackers]
    @data = result[:chart_data]
    @chart_interval = result[:chart_interval]
    @min_weight = result[:min_weight]
    @max_weight = result[:max_weight]
    @min_date = result[:min_date]
    @max_date = result[:max_date]
    @dry_properties = result[:dry_properties]
    @wet_properties = result[:wet_properties]

    # For public view, we usually show a fixed number of recent records or allow pagination
    page = params[:page].blank? ? 1 : params[:page]
    @trackers = @all_trackers.order(date: :desc, feed_time: :desc).paginate(page: page, per_page: 120)

    render layout: "application"
  end
end
