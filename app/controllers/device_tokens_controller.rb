# The Android app's notification token (checkpoint I), sent by the push bridge
# component on signed-in pages: registered for the signed-in person and this
# sign-in session, with whether the phone shows notifications, or removed. JSON only.
class DeviceTokensController < ApplicationController
  # The app sends its token when a page loads; far fewer than this.
  rate_limit to: 60, within: 1.hour, only: :create, by: -> { Current.user.id }, with: -> { head :too_many_requests }
  def create
    token = DeviceToken.register(user: Current.user, session: Current.session, token: params.require(:token),
                                 platform: params[:platform].presence || "android", notifications_allowed: notifications_allowed)
    head(token.persisted? ? :no_content : :unprocessable_content)
  end

  def destroy
    Current.user.device_tokens.where(token: params.require(:token).to_s).delete_all
    head :no_content
  end

  private

  def notifications_allowed
    ActiveModel::Type::Boolean.new.cast(params[:notifications_allowed]) unless params[:notifications_allowed].nil?
  end
end
