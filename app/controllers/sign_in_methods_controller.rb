# The profile page's "Sign-in methods": disconnecting Google, LINE or GitHub.
# Connecting goes through the provider and ends in OmniAuth::SessionsController.
class SignInMethodsController < ApplicationController
  def destroy
    provider = params[:provider].presence_in(ConnectedService::PROVIDERS) or return head(:not_found)

    Current.user.connected_services.where(provider: provider).destroy_all
    redirect_to users_path(anchor: "sign-in-methods"), notice: t(".notice", provider: ConnectedService.provider_name(provider)), status: :see_other
  end
end
