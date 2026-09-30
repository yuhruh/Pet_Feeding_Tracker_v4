# The member a household was offered to reviews and accepts it. Only that member,
# signed in, can see or accept the offer.
class OwnershipTransferOffersController < ApplicationController
  before_action :set_transfer

  def show
  end

  def update
    if @transfer.accept!(Current.user)
      redirect_to household_path, notice: t(".notice", household: helpers.household_name(@transfer.household))
    else
      redirect_to ownership_transfer_offer_path(@transfer), alert: @transfer.errors.map(&:message).to_sentence
    end
  end

  private

  def set_transfer
    @transfer = Current.user.incoming_ownership_transfers.includes(household: :owner).find_by(id: params[:id])
    redirect_to today_path, alert: t("ownership_transfer_offers.not_found") unless @transfer
  end
end
