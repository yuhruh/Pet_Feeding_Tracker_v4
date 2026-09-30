# A caregiver or viewer leaving someone else's household.
class HouseholdMembershipsController < ApplicationController
  def destroy
    membership = Current.user.household_memberships.includes(household: :owner).find_by!(household_id: params[:household_id])
    membership.destroy!
    redirect_to users_path, notice: t(".notice", household: helpers.household_name(membership.household)), status: :see_other
  rescue ActiveRecord::RecordNotFound
    redirect_to users_path, status: :see_other
  end
end
