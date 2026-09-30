# Finds a pet the signed-in user may reach and checks what their household role
# allows. A pet outside the user's households is "not found", as it always was; a
# pet they can reach but not change sends them back to what they may see.
module PetAccess
  extend ActiveSupport::Concern

  included do
    helper_method :household_policy
  end

  private

  def household_policy
    @household_policy ||= HouseholdPolicy.new(Current.user, @pet&.household)
  end

  # Loads @pet and checks `permission`; renders a response (so the action stops)
  # when the pet is out of reach or the role doesn't allow it.
  def load_pet(id, permission)
    @pet = Pet.accessible_by(Current.user).find(id)
    deny_pet_access unless household_policy.can?(permission)
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to pets_path, alert: t("pets.not_found") }
      format.json { render_json_error(t("pets.not_found"), status: :not_found) }
      format.any { head :not_found }
    end
  end

  def deny_pet_access
    respond_to do |format|
      format.html do
        back = household_policy.can?(:view_charts) ? pet_trackers_path(@pet) : pets_path
        redirect_to back, alert: t("households.owner_only", petname: @pet.petname.capitalize)
      end
      format.json { render_json_error(t("households.owner_only", petname: @pet.petname.capitalize), status: :forbidden) }
      format.any { head :forbidden }
    end
  end
end
