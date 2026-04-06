class UserMailer < ApplicationMailer
  default from: "ajicaretracker@gmail.com"

  def welcome_email
    @user = params[:user]
    mail(to: @user.email_address, cc: "ajicaretracker@gmail.com", subject: t(".subject"))
  end

  def send_pet_weight_reminder(user)
    @user = user
    mail(to: @user.email_address, cc: "ajicaretracker@gmail.com", subject: t(".subject"))
  end
end
