# The owner offers their household to one of its members, or withdraws the offer.
class OwnershipTransfersController < ApplicationController
  include OwnedHousehold

  def create
    member = @household.members.find_by(id: params[:to_user_id])
    # A new offer replaces an earlier one.
    @household.ownership_transfers.pending.update_all(cancelled_at: Time.current)
    transfer = @household.ownership_transfers.new(from_user: Current.user, to_user: member)

    if member && transfer.save
      HouseholdMailer.with(transfer: transfer, locale: I18n.locale.to_s).ownership_transfer.deliver_later
      redirect_to household_path(anchor: "transfer"), notice: t(".notice", name: member.username)
    else
      message = member ? transfer.errors.map(&:message).to_sentence : t("activerecord.errors.models.ownership_transfer.attributes.to_user.not_a_member")
      redirect_to household_path(anchor: "transfer"), alert: message
    end
  end

  def destroy
    @household.ownership_transfers.pending.find(params[:id]).cancel!
    redirect_to household_path(anchor: "transfer"), notice: t(".notice"), status: :see_other
  end
end
