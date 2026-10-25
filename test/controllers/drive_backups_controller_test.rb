require "test_helper"
require "minitest/mock"

class DriveBackupsControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    @user = users(:one)
    log_in_as(@user)
  end

  def start_connect
    post connect_drive_backup_path
    URI.decode_www_form(URI(response.location).query).to_h
  end

  test "connect sends the owner to Google with a state and the plain callback address" do
    query = start_connect

    assert response.location.start_with?(GoogleDriveClient::AUTH_URL)
    assert_equal "http://www.example.com/drive_backup/callback", query["redirect_uri"]
    assert query["state"].present?
  end

  test "the callback connects Drive and starts the first backup" do
    state = start_connect["state"]

    GoogleDriveClient.stub(:exchange_code, "refresh-1") do
      GoogleDriveClient.stub(:new, Struct.new(:email).new("one@gmail.com")) do
        assert_enqueued_jobs 1, only: DriveBackupUploadJob do
          get drive_backup_callback_path, params: { state: state, code: "code-1" }
        end
      end
    end

    assert_redirected_to users_path(anchor: "drive-backup")
    backup = @user.reload.drive_backup
    assert_equal [ "refresh-1", "one@gmail.com" ], [ backup.refresh_token, backup.google_email ]
  end

  test "a callback with the wrong state connects nothing" do
    start_connect

    GoogleDriveClient.stub(:exchange_code, ->(*) { flunk "must not trade the code" }) do
      get drive_backup_callback_path, params: { state: "someone-elses", code: "code-1" }
    end

    assert_redirected_to users_path(anchor: "drive-backup")
    assert_nil @user.reload.drive_backup
  end

  test "cancelling on Google's screen connects nothing" do
    state = start_connect["state"]
    get drive_backup_callback_path, params: { state: state, error: "access_denied" }

    assert_equal I18n.t("drive_backups.callback.cancelled"), flash[:alert]
    assert_nil @user.reload.drive_backup
  end

  test "the owner picks the backup hour" do
    backup = @user.create_drive_backup!(refresh_token: "refresh-1")
    patch drive_backup_path, params: { drive_backup: { backup_hour: 7 } }

    assert_redirected_to users_path(anchor: "drive-backup")
    assert_equal 7, backup.reload.backup_hour
  end

  test "back up now starts a backup" do
    backup = @user.create_drive_backup!(refresh_token: "refresh-1")

    assert_enqueued_with job: DriveBackupUploadJob, args: [ backup ] do
      post run_drive_backup_path
    end
  end

  test "disconnecting revokes access and forgets the connection" do
    @user.create_drive_backup!(refresh_token: "refresh-1")
    revoked = []

    GoogleDriveClient.stub(:revoke, ->(token) { revoked << token }) { delete drive_backup_path }

    assert_equal [ "refresh-1" ], revoked
    assert_nil @user.reload.drive_backup
  end

  test "the profile page offers to connect Drive" do
    get users_path
    assert_select "#drive-backup form[action='#{connect_drive_backup_path}']"
  end

  test "a helper without cats of their own can't connect Drive" do
    helper = User.create!(email_address: "helper@example.com", password: "password123", password_confirmation: "password123",
                          username: "Helper", timezone: "Asia/Taipei")
    delete session_path
    log_in_as(helper)

    post connect_drive_backup_path
    assert_redirected_to users_path
  end
end
