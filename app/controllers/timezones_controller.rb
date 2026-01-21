class TimezonesController < ApplicationController
  allow_unauthenticated_access only: :create

  def create
    session[:timezone] = params[:timezone]
    redirect_to "/auth/#{params[:provider]}"
  end
end
