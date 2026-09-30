# Turns a pet's public share link on (with a new token each time) and off.
class PetSharesController < ApplicationController
  include PetAccess
  before_action :set_pet

  def create
    unless Pet::SHARE_DURATIONS.key?(params[:expires_in].to_s)
      return redirect_to pet_trackers_path(@pet), alert: t(".invalid_duration")
    end

    @pet.share!(expires_in: Pet::SHARE_DURATIONS[params[:expires_in].to_s])
    redirect_to pet_trackers_path(@pet), notice: t(".notice"), status: :see_other
  end

  def destroy
    @pet.stop_sharing!
    redirect_to pet_trackers_path(@pet), notice: t(".notice"), status: :see_other
  end

  private
    # Only the owner turns a public link on or off.
    def set_pet
      load_pet(params[:pet_id], :manage_share)
    end
end
