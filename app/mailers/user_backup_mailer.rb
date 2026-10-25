class UserBackupMailer < ApplicationMailer
  def backup_email(user)
    @user = user

    # Attach CSVs for each pet
    @user.owned_pets.each do |pet|
      attachments[pet.backup_filename(Time.current)] = pet.trackers_csv(@user.timezone)
    end

    mail(to: @user.email_address, cc: "ajicaretracker@gmail.com", subject: I18n.t("mailers.user_backup.subject"))
  end
end
