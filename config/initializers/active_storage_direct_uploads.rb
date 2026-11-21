# Direct uploads only for signed-in people (see SignedInDirectUploads).
Rails.application.config.to_prepare do
  ActiveStorage::DirectUploadsController.include SignedInDirectUploads
end
