# A pet's latest kibble price check, and "Refresh now". Owner only.
class KibblePricesController < ApplicationController
  # Each refresh queues a search of BigGo and PChome, so a user can't queue many at once.
  rate_limit to: 5, within: 10.minutes, only: :create, by: -> { Current.user.id },
             with: -> { redirect_to pet_kibble_prices_path(params[:pet_id]), alert: t("kibble_prices.create.rate_limited") }
  before_action :set_pet

  def index
    @check = @pet.kibble_price_checks.latest_first.first
    @checked_today = @pet.kibble_price_checks.exists?(checked_on: Date.current)
  end

  def create
    if @pet.kibble_price_checks.exists?(checked_on: Date.current)
      redirect_to pet_kibble_prices_path(@pet), notice: t(".already_checked")
    else
      PetKibblePriceJob.perform_later(@pet, Date.current)
      redirect_to pet_kibble_prices_path(@pet), notice: t(".queued")
    end
  end

  private

  def set_pet
    @pet = Current.user.pets.find(params[:pet_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to pets_path, alert: t("pets.not_found")
  end
end
