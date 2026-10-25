require "test_helper"

class DriveBackupTest < ActiveSupport::TestCase
  # Stands in for Google Drive: remembers what was uploaded and trashed.
  class FakeDrive
    attr_reader :uploads, :folders_created, :trashed
    attr_accessor :folder_exists, :fail_with

    def initialize
      @uploads = []
      @trashed = []
      @folders_created = 0
      @folder_exists = true
    end

    def folder?(_id) = folder_exists

    def create_folder(_name)
      @folders_created += 1
      "folder-#{@folders_created}"
    end

    def upload_csv(name:, csv:, folder_id:, file_id:)
      raise fail_with if fail_with

      @uploads << { name: name, csv: csv, folder_id: folder_id, file_id: file_id }
      file_id || "file-#{@uploads.size}"
    end

    def trash_file(id)
      @trashed << id
      true
    end
  end

  setup do
    @user = users(:one) # Asia/Taipei
    @backup = @user.create_drive_backup!(refresh_token: "refresh-1", google_email: "one@gmail.com", backup_hour: 22)
    @drive = FakeDrive.new
  end

  def taipei_today = Time.current.in_time_zone("Asia/Taipei").to_date
  def first_pet = @user.owned_pets.order(:id).first

  test "is due once, in the chosen hour on the user's clock" do
    taipei_10pm = Time.utc(2026, 10, 25, 14, 20) # 22:20 in Taipei

    assert @backup.due?(taipei_10pm)
    assert_not @backup.due?(taipei_10pm - 1.hour)
    @backup.update!(last_attempted_at: taipei_10pm - 5.minutes)
    assert_not @backup.due?(taipei_10pm)
    assert @backup.due?(taipei_10pm + 1.day)
  end

  test "is never due once Google access was removed" do
    @backup.update!(refresh_token: nil)
    assert_not @backup.due?(Time.utc(2026, 10, 25, 14, 20))
  end

  test "makes the folder, then uploads one CSV per cat named with the user's date" do
    @drive.folder_exists = false
    @backup.back_up!(@drive)

    pets = @user.owned_pets.order(:id).to_a
    assert_equal 1, @drive.folders_created
    assert_equal pets.map { |pet| pet.backup_filename(taipei_today) }, @drive.uploads.map { |upload| upload[:name] }
    assert_match(/_trackers_petid_#{pets.first.id}_#{taipei_today.strftime('%Y%m%d')}\.csv\z/, @drive.uploads.first[:name])
    assert @drive.uploads.all? { |upload| upload[:folder_id] == "folder-1" && upload[:file_id].nil? }
    assert_equal pets.map { |pet| pet.id.to_s }, @backup.reload.file_ids.keys
    assert @backup.file_ids.values.all? { |files| files.keys == [ taipei_today.iso8601 ] }
    assert_not_nil @backup.last_backed_up_at
  end

  test "a new day adds a new file, and a second backup the same day replaces that day's" do
    yesterday = (taipei_today - 1).iso8601
    @backup.update!(folder_id: "folder-9", file_ids: { first_pet.id.to_s => { yesterday => "old-file" } })

    @backup.back_up!(@drive)
    assert_nil @drive.uploads.first[:file_id], "yesterday's file must stay as it is"
    today_id = @backup.reload.file_ids[first_pet.id.to_s][taipei_today.iso8601]
    assert_equal({ yesterday => "old-file", taipei_today.iso8601 => today_id }, @backup.file_ids[first_pet.id.to_s])

    @backup.back_up!(@drive)
    assert_equal today_id, @drive.uploads.last[:file_id]
    assert_equal 0, @drive.folders_created
  end

  test "keeps #{DriveBackup::KEEP_DAYS} days and moves older files to the Drive trash" do
    last_kept = (taipei_today - (DriveBackup::KEEP_DAYS - 1)).iso8601
    too_old = (taipei_today - DriveBackup::KEEP_DAYS).iso8601
    @backup.update!(folder_id: "folder-9", file_ids: { first_pet.id.to_s => { too_old => "too-old", last_kept => "last-kept" } })

    @backup.back_up!(@drive)

    assert_equal [ "too-old" ], @drive.trashed
    assert_equal [ last_kept, taipei_today.iso8601 ], @backup.reload.file_ids[first_pet.id.to_s].keys.sort
  end

  test "a deleted cat's files are never trashed" do
    @backup.update!(folder_id: "folder-9", file_ids: { "999999" => { "2020-01-01" => "gone-cat-file" } })
    @backup.back_up!(@drive)

    assert_empty @drive.trashed
    assert_not_includes @backup.reload.file_ids.keys, "999999"
  end

  test "a revoked token stops the backups until the user connects again" do
    @drive.fail_with = GoogleDriveClient::Unauthorized.new("Google Drive token request was refused (400)")
    @backup.back_up!(@drive)

    assert_not @backup.reload.connected?
    assert_match "refused", @backup.last_error
  end

  test "another Drive error is kept for the profile page and raised for a retry" do
    @drive.fail_with = GoogleDriveClient::Error.new("Google Drive upload failed (500): backend error")

    assert_raises(GoogleDriveClient::Error) { @backup.back_up!(@drive) }
    assert @backup.reload.connected?
    assert_equal "Google Drive upload failed (500): backend error", @backup.last_error
    assert_nil @backup.last_backed_up_at
  end

  test "keeps the Drive refresh token encrypted" do
    stored = DriveBackup.connection.select_value("SELECT refresh_token FROM drive_backups WHERE id = #{@backup.id}")
    assert_not_includes stored, "refresh-1"
  end
end
