# For pages only a household's owner uses: loads the signed-in user's own household.
module OwnedHousehold
  extend ActiveSupport::Concern

  included do
    before_action :set_owned_household
  end

  private

  def set_owned_household
    @household = Current.user.owned_household
    redirect_to new_pet_path, alert: t("households.needs_a_cat") unless @household
  end
end
