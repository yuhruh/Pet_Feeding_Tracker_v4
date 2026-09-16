module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
    helper_method :authenticated?
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private
    def authenticated?
      resume_session
    end

    def require_authentication
      resume_session || request_authentication
    end

    def resume_session
      Current.session ||= find_session_by_cookie
    end

    def find_session_by_cookie
      return unless cookies.signed[:session_id]

      found = Session.find_by(id: cookies.signed[:session_id])
      if found.nil? || found.expired?
        found&.destroy
        cookies.delete(:session_id)
        return
      end

      found.record_activity
      found
    end

    def request_authentication
      session[:return_to_after_authenticating] = request.url
      flash[:alert] = t("authentication.required")
      redirect_to new_session_path
    end

    def after_authentication_url
      session.delete(:return_to_after_authenticating) || root_url
    end

    def start_new_session_for(user)
      user.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |session|
        Current.session = session
        cookies.signed[:session_id] = { value: session.id, httponly: true, same_site: :lax, expires: session.expires_at }
      end
    end

    def terminate_session
      Current.session.destroy
      cookies.delete(:session_id)
    end
end
