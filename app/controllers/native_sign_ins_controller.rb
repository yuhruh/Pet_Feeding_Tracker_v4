# Sign in with Google, LINE or GitHub in the Android app (checkpoint I2).
# start: opened by the app in a Chrome Custom Tab; starts the provider sign-in
#   in Chrome, so the OAuth state cookie and the callback are in one browser.
#   OmniAuth::SessionsController then hands the result back with a one-time
#   code instead of signing Chrome in.
# finish: opened by the app in its WebView with that code; signs the app in,
#   but only the WebView session whose sign-in page started it (NativeSignIn).
class NativeSignInsController < ApplicationController
  include HouseholdArrival
  allow_unauthenticated_access

  PROVIDERS = ConnectedService::PROVIDERS

  def start
    @provider = params[:provider].presence_in(PROVIDERS) or return head(:not_found)

    context = NativeSignIn.read_context(params[:context])
    # Not from the app's sign-in page, or from one left open too long: nothing is
    # started; the app shows its sign-in page again, with a fresh link.
    return back_to_the_app_to_retry if context["challenge"].blank?

    # Chrome's own session: that this is the app's sign-in. An invitation or viewer
    # link the app holds stays in the app's session (used in finish), so a link
    # opened in someone else's browser can't put one there.
    session[:native_sign_in] = { "locale" => context["locale"].presence_in(I18n.available_locales.map(&:to_s)) || I18n.locale.to_s,
                                 "started_at" => Time.current.to_i, "challenge" => context["challenge"] }
    I18n.locale = session[:native_sign_in]["locale"]
    render layout: false
  end

  def finish
    sign_in = NativeSignIn.redeem(params[:code], session)
    return redirect_to new_session_path, alert: t(".expired") unless sign_in

    # LINE without an email: the sign-up page finishes it, as on the website.
    remember_provider_identity(sign_in.data["omniauth_auth"]) if sign_in.data["omniauth_auth"]
    return redirect_to(sign_in.safe_path, sign_in.flash.symbolize_keys.slice(:notice, :alert)) unless sign_in.user

    start_new_session_for(sign_in.user)
    forget_provider_identity
    # The invitation or viewer link this app session opened before signing in.
    if (arrival = claim_household_invitation(sign_in.user))
      redirect_to landing_path_for(sign_in.user), arrival
    else
      redirect_to sign_in.safe_path, sign_in.flash.symbolize_keys.slice(:notice, :alert)
    end
  end

  private

  # A code that redeems nothing: finish answers it with "please sign in again".
  def back_to_the_app_to_retry
    @app_url = NativeSignIn.app_url("expired", fallback_url: new_session_url)
    render :return, layout: false
  end
end
