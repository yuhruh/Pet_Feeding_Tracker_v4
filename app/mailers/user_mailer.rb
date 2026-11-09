class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    mail(to: @user.email_address, cc: "ajicaretracker@gmail.com", subject: t(".subject"))
  end

  # Pets due a weighing, when the owner doesn't get it in the Android app or by
  # LINE. The text is built by PetWeightReminderNotifier in their language.
  def send_pet_weight_reminder
    @user = params[:user]
    @lines = params[:lines]
    @url = params[:url]
    @problem = params[:problem]
    I18n.with_locale(params[:locale].presence || I18n.default_locale) do
      mail(to: @user.email_address, cc: "ajicaretracker@gmail.com", subject: params[:subject])
    end
  end
end
