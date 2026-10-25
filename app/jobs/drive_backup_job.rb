# Hourly (config/recurring.yml): starts the Google Drive backup of each connected
# user whose chosen hour it is on their own clock. See DriveBackup#due?.
class DriveBackupJob < ApplicationJob
  queue_as :default

  def perform(now = Time.current)
    DriveBackup.connected.includes(:user).find_each do |backup|
      DriveBackupUploadJob.perform_later(backup) if backup.due?(now)
    end
  end
end
