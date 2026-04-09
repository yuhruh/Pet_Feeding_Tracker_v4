class UserBackupJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      UserBackupMailer.backup_email(user).deliver_later
    end
  end
end
