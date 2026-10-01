# A person's reminders for one household, when they don't get them by LINE
# (checkpoint H). The text is built by CareReminderNotifier in their language.
class CareReminderMailer < ApplicationMailer
  def reminders
    @lines = params[:lines]
    @today_url = params[:today_url]
    I18n.with_locale(params[:locale].presence || I18n.default_locale) do
      mail(to: params[:user].email_address, subject: params[:subject])
    end
  end
end
