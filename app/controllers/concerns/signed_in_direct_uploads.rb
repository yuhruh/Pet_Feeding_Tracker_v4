# Active Storage's direct-upload endpoint (the cat photo on the cat form) is
# its own controller, outside ApplicationController, so anyone could store
# files on the server. This limits it to signed-in people, to cat photos (the
# only thing uploaded this way) and to a sensible number per hour. Photos never
# attached to a cat are purged by the daily purge_unattached_uploads job.
# Included in config/initializers/active_storage_direct_uploads.rb.
module SignedInDirectUploads
  extend ActiveSupport::Concern

  UPLOADS_PER_HOUR = 30

  included do
    before_action :require_signed_in_for_direct_upload
    before_action :require_a_cat_photo
    rate_limit to: UPLOADS_PER_HOUR, within: 1.hour, by: -> { @direct_upload_session.user_id },
               with: -> { head :too_many_requests }
  end

  private

  def require_signed_in_for_direct_upload
    session_id = cookies.signed[:session_id]
    @direct_upload_session = session_id && Session.find_by(id: session_id)
    head :unauthorized unless @direct_upload_session && !@direct_upload_session.expired?
  end

  # What the browser says it will send. Disk uploads must match it (Active Storage
  # checks the length and type it signed), and Pet checks the stored file again.
  def require_a_cat_photo
    blob = params[:blob]
    byte_size = blob.respond_to?(:[]) ? blob[:byte_size].to_s : ""
    content_type = blob.respond_to?(:[]) ? blob[:content_type].to_s : ""
    acceptable = byte_size.match?(/\A\d+\z/) && byte_size.to_i.between?(1, Pet::AVATAR_MAX_SIZE) &&
                 Pet::AVATAR_CONTENT_TYPES.include?(content_type)
    head :unprocessable_entity unless acceptable
  end
end
