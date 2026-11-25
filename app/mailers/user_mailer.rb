class UserMailer < ApplicationMailer
  # The link that confirms the address (User#email_confirmed?). It goes to an
  # address nobody has proven yet, so it carries no text the person typed.
  def email_confirmation
    @user = params[:user]
    I18n.with_locale(params[:locale].presence || I18n.default_locale) do
      @confirm_url = email_confirmation_url(token: @user.generate_token_for(:email_confirmation), locale: I18n.locale)
      mail(to: @user.email_address, subject: t(".subject"))
    end
  end

  def welcome_email
    @user = params[:user]
    mail(to: @user.email_address, subject: t(".subject"))
  end

  # Pets due a weighing, when the owner doesn't get it in the Android app or by
  # LINE. The text is built by PetWeightReminderNotifier in their language.
  def send_pet_weight_reminder
    @user = params[:user]
    @lines = params[:lines]
    @url = params[:url]
    @problem = params[:problem]
    I18n.with_locale(params[:locale].presence || I18n.default_locale) do
      mail(to: @user.email_address, subject: params[:subject])
    end
  end
end
