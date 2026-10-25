require "test_helper"

class DriveBackupJobTest < ActiveJob::TestCase
  test "starts only the backups due this hour" do
    due = users(:one).create_drive_backup!(refresh_token: "refresh-1", backup_hour: 22) # Asia/Taipei
    users(:two).create_drive_backup!(refresh_token: "refresh-2", backup_hour: 9)

    assert_enqueued_jobs 1, only: DriveBackupUploadJob do
      DriveBackupJob.perform_now(Time.utc(2026, 10, 25, 14, 20)) # 22:20 in Taipei
    end
    assert_enqueued_with job: DriveBackupUploadJob, args: [ due ]
  end
end
