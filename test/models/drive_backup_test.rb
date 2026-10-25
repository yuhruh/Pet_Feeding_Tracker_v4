require "test_helper"

class DriveBackupTest < ActiveSupport::TestCase
  # Stands in for Google Drive: remembers what was uploaded.
  class FakeDrive
    attr_reader :uploads, :folders_created
    attr_accessor :folder_exists, :fail_with

    def initialize
      @uploads = []
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
  end

  setup do
    @user = users(:one) # Asia/Taipei
    @backup = @user.create_drive_backup!(refresh_token: "refresh-1", google_email: "one@gmail.com", backup_hour: 22)
    @drive = FakeDrive.new
  end

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

  test "makes the folder, then uploads one CSV per cat and remembers the files" do
    @drive.folder_exists = false
    @backup.back_up!(@drive)

    pets = @user.owned_pets.order(:id).to_a
    assert_equal 1, @drive.folders_created
    assert_equal pets.map(&:backup_filename), @drive.uploads.map { |upload| upload[:name] }
    assert @drive.uploads.all? { |upload| upload[:folder_id] == "folder-1" }
    assert_equal pets.map { |pet| pet.id.to_s }, @backup.reload.file_ids.keys
    assert_not_nil @backup.last_backed_up_at
  end

  test "the next backup replaces the same files" do
    @backup.update!(folder_id: "folder-9", file_ids: @user.owned_pets.to_h { |pet| [ pet.id.to_s, "file-of-#{pet.id}" ] })
    @backup.back_up!(@drive)

    assert_equal 0, @drive.folders_created
    assert_equal @user.owned_pets.order(:id).map { |pet| "file-of-#{pet.id}" }, @drive.uploads.map { |upload| upload[:file_id] }
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
