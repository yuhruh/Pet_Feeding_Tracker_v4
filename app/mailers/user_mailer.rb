class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    mail(to: @user.email_address, subject: t(".subject"))
  end

  def send_pet_weight_reminder(user)
    @user = user
    mail(to: @user.email_address, subject: t(".subject"))
  end
end
