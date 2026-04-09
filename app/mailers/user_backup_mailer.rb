class UserBackupMailer < ApplicationMailer
  def backup_email(user)
    @user = user

    # Attach CSVs for each pet
    @user.pets.each do |pet|
      csv_data = pet.trackers.to_csv
      attachments["#{pet.petname}_trackers_#{Time.current.strftime('%Y%m%d')}.csv"] = csv_data
    end

    mail(to: @user.email_address, subject: I18n.t("mailers.user_backup.subject", default: "Your Pet Tracker Backup"))
  end
end
