class ApplicationController < ActionController::Base
  include Authentication
  helper SvgHelper
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern, block: -> { 
    # Allow the request if it's from our Native app even if the engine version is technically "old"
    return if hotwire_native_app?
    render file: Rails.root.join("public/406-unsupported-browser.html"), layout: false, status: :not_acceptable
  }
  before_action :set_variant
  before_action :set_locale
  before_action :set_user_time_zone

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def set_variant
    request.variant = :native if hotwire_native_app?
  end

  def hotwire_native_app?
    request.user_agent&.include?("Hotwire Native") || request.user_agent&.include?("Turbo Native")
  end
  helper_method :hotwire_native_app?

  def set_locale
    # if params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)
    #   session[:locale] = params[:locale]
    # end

    # I18n.locale = session[:locale] || I18n.default_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_user_time_zone
    Time.zone = Current.user.timezone if Current.user&.timezone
  end
end
