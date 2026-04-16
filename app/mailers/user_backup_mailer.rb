class UserBackupMailer < ApplicationMailer
  def backup_email(user)
    @user = user

    # Attach CSVs for each pet
    @user.pets.each do |pet|
      # Sort in Ruby to handle timezone wrapping correctly, with safety for nil times
      sorted_trackers = pet.trackers.to_a.sort_by { |t| [t.date, t.feed_time&.strftime("%H:%M") || "00:00"] }
      csv_data = Tracker.to_csv(sorted_trackers)
      attachments["#{pet.petname}_trackers_#{Time.current.strftime('%Y%m%d')}.csv"] = csv_data
    end

    mail(to: @user.email_address, cc: "ajicaretracker@gmail.com", subject: I18n.t("mailers.user_backup.subject"))
  end
end
