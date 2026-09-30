# The owner removes a caregiver or viewer from their household.
class HouseholdMembersController < ApplicationController
  include OwnedHousehold

  def destroy
    membership = @household.memberships.find(params[:id])
    membership.destroy!
    redirect_to household_path, notice: t(".notice", name: membership.user.username), status: :see_other
  end
end
