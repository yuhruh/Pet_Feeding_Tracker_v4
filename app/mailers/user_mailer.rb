class UserMailer < ApplicationMailer
  default from: "ajicaretracker@gmail.com"

  def welcome_email
    @user = params[:user]
    mail(to: @user.email_address, cc: "ajicaretracker@gmail.com", subject: "Welcome to Cat Trackers App!")
  end
end
