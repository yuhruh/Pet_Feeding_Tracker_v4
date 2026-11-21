# Active Storage's direct-upload endpoint (the cat photo on the cat form) is
# its own controller, outside ApplicationController, so anyone could store
# files on the server. This limits it to signed-in people.
# Included in config/initializers/active_storage_direct_uploads.rb.
module SignedInDirectUploads
  extend ActiveSupport::Concern

  included do
    before_action :require_signed_in_for_direct_upload
  end

  private

  def require_signed_in_for_direct_upload
    session_id = cookies.signed[:session_id]
    signed_in = session_id && Session.find_by(id: session_id)
    head :unauthorized unless signed_in && !signed_in.expired?
  end
end
