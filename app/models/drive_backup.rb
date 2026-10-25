# A user's daily copy of their cats' feeding records in a folder of their own Google
# Drive: a new CSV per cat each day, named with the date, and the last KEEP_DAYS kept.
# A row without a refresh token means Google access was removed and the user has to
# connect again; disconnecting deletes the row.
#
# file_ids: { "pet id" => { "2026-10-25" => "Drive file id", ... } }
class DriveBackup < ApplicationRecord
  FOLDER_NAME = "Pet Tracker Backups"
  KEEP_DAYS = 30

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

    # A second backup the same day replaces that day's file. Rebuilt each time, so a
    # deleted cat drops out and its files stay in Drive: they're its only records.
    today = Time.current.in_time_zone(time_zone).to_date
    uploaded = user.owned_pets.order(:id).to_h do |pet|
      files = file_ids[pet.id.to_s].is_a?(Hash) ? file_ids[pet.id.to_s] : {}
      id = client.upload_csv(name: pet.backup_filename(today), csv: pet.trackers_csv(user.timezone),
                             folder_id: folder_id, file_id: files[today.iso8601])
      [ pet.id.to_s, files.merge(today.iso8601 => id) ]
    end
    update!(file_ids: uploaded, last_backed_up_at: Time.current, last_error: nil)

    # Saved first, so a failure here never loses today's file ids.
    cutoff = (today - (KEEP_DAYS - 1)).iso8601
    kept = file_ids.transform_values do |files|
      files.reject { |date, id| date < cutoff && client.trash_file(id) }
    end
    update!(file_ids: kept)
  rescue GoogleDriveClient::Unauthorized => error
    update!(refresh_token: nil, last_error: error.message)
  rescue GoogleDriveClient::Error => error
    update!(last_error: error.message)
    raise
  end

  private

  def time_zone = ActiveSupport::TimeZone[user.timezone.to_s] || ActiveSupport::TimeZone["UTC"]
end
