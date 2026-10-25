# One user's Google Drive backup, on its own so one slow or failing Drive doesn't
# hold up the others. A refused token isn't retried: the user has to connect again.
class DriveBackupUploadJob < ApplicationJob
  queue_as :default
  retry_on GoogleDriveClient::Error, wait: 10.minutes, attempts: 3
  # Disconnected before the job ran.
  discard_on ActiveJob::DeserializationError

  def perform(backup)
    backup.back_up!
  end
end
