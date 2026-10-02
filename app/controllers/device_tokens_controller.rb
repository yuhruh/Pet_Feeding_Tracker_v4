# The Android app's notification token (checkpoint I), sent by the push bridge
# component on signed-in pages: registered for the signed-in person and this
# sign-in session, or removed. JSON only.
class DeviceTokensController < ApplicationController
  def create
    token = DeviceToken.register(user: Current.user, session: Current.session, token: params.require(:token), platform: params[:platform].presence || "android")
    head(token.persisted? ? :no_content : :unprocessable_content)
  end

  def destroy
    Current.user.device_tokens.where(token: params.require(:token).to_s).delete_all
    head :no_content
  end
end
