require "test_helper"

class UserBackupMailerTest < ActionMailer::TestCase
  test "backup_email" do
    user = users(:one)
    mail = UserBackupMailer.backup_email(user)
    assert_equal "Your Pet Tracker Backup", mail.subject
    assert_equal [ user.email_address ], mail.to
    assert_equal [ "ajicaretracker@gmail.com" ], mail.from
    assert_match /Attached is your pet tracking data backup/, mail.html_part.body.decoded
  end

  test "backup_email sanitizes pet name and prevents overwrites with duplicate names" do
    user = users(:one)

    # Create pets with slash in name and same name to test sanitization and collision avoidance
    pet_with_slash = Pet.create!(user: user, petname: "Mimi/Momo", birthday: 2.years.ago)
    pet_with_duplicate = Pet.create!(user: user, petname: "Mimi/Momo", birthday: 2.years.ago)

    mail = UserBackupMailer.backup_email(user)

    # Verify both attachments are created with unique safe names
    attachment_names = mail.attachments.map(&:filename)

    # Expected sanitized string is "Mimi_Momo"
    assert_includes attachment_names, "Mimi_Momo_trackers_#{pet_with_slash.id}_#{Time.current.strftime('%Y%m%d')}.csv"
    assert_includes attachment_names, "Mimi_Momo_trackers_#{pet_with_duplicate.id}_#{Time.current.strftime('%Y%m%d')}.csv"
  end
end
