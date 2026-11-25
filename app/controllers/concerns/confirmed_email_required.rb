# Sharing (invitations, viewer links, share links, vet visits) needs a
# confirmed email address (User#email_confirmed?), so an account opened with
# someone else's address can't hand out access to what that person later adds.
module ConfirmedEmailRequired
  extend ActiveSupport::Concern

  private

  def require_confirmed_email
    return if Current.user&.email_confirmed?

    redirect_back fallback_location: users_path,
                  alert: t("email_confirmations.required", email: Current.user&.email_address)
  end
end
