class UserBackupJob < ApplicationJob
  queue_as :default

  def perform
    queued = 0

    # Only send emails to users who have created or updated at least one tracker in the last 25 hours (1 day with safety buffer)
    User.find_each do |user|
      has_recent_trackers = Tracker.joins(:pet).where(pets: { user_id: user.id }).where("trackers.updated_at >= ?", 25.hours.ago).exists?

      if has_recent_trackers
        UserBackupMailer.backup_email(user).deliver_later
        queued += 1
      end
    end

    # Logged so the host's logs show whether the nightly run happened, and for how many users.
    Rails.logger.info("[UserBackupJob] queued #{queued} backup #{'email'.pluralize(queued)} for users with tracker changes in the last 25 hours")
  end
end
