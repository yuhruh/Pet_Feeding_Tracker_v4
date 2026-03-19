class UserMailer < ApplicationMailer
  default from: "ajicaretracker@gmail.com"

  def welcome_email
    @user = params[:user]
    mail(to: @user.email_address, cc: "ajicaretracker@gmail.com", subject: "Welcome to Cat Trackers App!")
  end

  def send_pet_weight_reminder(user)
    @user = user
    mail(to: @user.email_address, cc: "ajicaretracker@gmail.com", subject: "Time to weigh your pet! 📝")
  end
end
