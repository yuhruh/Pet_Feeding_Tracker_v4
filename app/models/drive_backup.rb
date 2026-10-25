# A user's daily copy of their cats' feeding records, one CSV per cat, in a folder
# of their own Google Drive. A row without a refresh token means Google access was
# removed and the user has to connect again; disconnecting deletes the row.
class DriveBackup < ApplicationRecord
  FOLDER_NAME = "Pet Tracker Backups"

  belongs_to :user
  encrypts :refresh_token

  validates :backup_hour, inclusion: { in: 0..23 }

  scope :connected, -> { where.not(refresh_token: nil) }

  def connected? = refresh_token.present?

  def folder_url = folder_id && "https://drive.google.com/drive/folders/#{folder_id}"

  # Once a day, in the hour the user picked on their own clock. The hourly job could
  # run twice in an hour (a deploy, a retry), so a recent try counts as done.
  def due?(now = Time.current)
    connected? && now.in_time_zone(time_zone).hour == backup_hour && !last_attempted_at&.after?(now - 1.hour)
  end

  def back_up!(client = GoogleDriveClient.new(refresh_token))
    return unless connected?

    update!(last_attempted_at: Time.current)
    unless folder_id.present? && client.folder?(folder_id)
      self.folder_id = client.create_folder(FOLDER_NAME)
      self.file_ids = {}
    end

    # Rebuilt each time, so a deleted cat's id drops out; its file stays in Drive.
    uploaded = user.owned_pets.order(:id).to_h do |pet|
      [ pet.id.to_s, client.upload_csv(name: pet.backup_filename, csv: pet.trackers_csv(user.timezone),
                                      folder_id: folder_id, file_id: file_ids[pet.id.to_s]) ]
    end
    update!(file_ids: uploaded, last_backed_up_at: Time.current, last_error: nil)
  rescue GoogleDriveClient::Unauthorized => error
    update!(refresh_token: nil, last_error: error.message)
  rescue GoogleDriveClient::Error => error
    update!(last_error: error.message)
    raise
  end

  private

  def time_zone = ActiveSupport::TimeZone[user.timezone.to_s] || ActiveSupport::TimeZone["UTC"]
end
