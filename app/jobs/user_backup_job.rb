class UserBackupJob < ApplicationJob
  queue_as :default

  def perform
    # Only send emails to users who have created at least one tracker in the last 1 day
    User.find_each do |user|
      has_recent_trackers = Tracker.joins(:pet).where(pets: { user_id: user.id }).where("trackers.created_at >= ?", 1.day.ago).exists?

      if has_recent_trackers
        UserBackupMailer.backup_email(user).deliver_later
      end
    end
  end
end
