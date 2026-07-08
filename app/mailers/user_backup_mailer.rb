class UserBackupMailer < ApplicationMailer
  def backup_email(user)
    @user = user

    # Attach CSVs for each pet
    @user.pets.each do |pet|
      # Sort in Ruby to handle timezone wrapping correctly, with safety for nil times
      timezone = @user.timezone
      sorted_trackers = pet.trackers.to_a.sort_by { |t| [ t.date, t.feed_time&.in_time_zone(timezone)&.strftime("%H:%M") || "00:00" ] }
      csv_data = Tracker.to_csv(sorted_trackers, timezone)

      # Sanitize pet name to prevent directory traversal / invalid character issues
      safe_petname = pet.petname.gsub(/[\/\\?%*:|"<>]/, "_")
      filename = "#{safe_petname}_trackers_#{pet.id}_#{Time.current.strftime('%Y%m%d')}.csv"
      attachments[filename] = csv_data
    end

    mail(to: @user.email_address, cc: "ajicaretracker@gmail.com", subject: I18n.t("mailers.user_backup.subject"))
  end
end
