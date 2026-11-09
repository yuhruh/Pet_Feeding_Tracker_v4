# Tells one owner which of their pets are due a weighing, in one message by one
# channel (see ReminderChannels): the Android app, else LINE, else email. In
# their language, with a link to the pet's records (or the pet list for several).
class PetWeightReminderNotifier
  include ReminderChannels

  # dues: PetWeightReminderJob::Due, one per pet.
  def initialize(user, dues)
    @user = user
    @dues = dues
  end

  # Returns the channel used: "android", "line" or "email".
  def deliver
    I18n.with_locale(locale) do
      return "android" if pushed_to_android?(title: subject, body: lines.join("\n"), url: url)
      return "line" if line_uid && pushed_by_line?([ subject, "", *lines, "", "#{I18n.t('weight_reminders.open')} #{url}" ].join("\n"))

      UserMailer.with(user: @user, subject: subject, lines: lines, url: url, locale: locale.to_s).send_pet_weight_reminder.deliver_later
      "email"
    end
  end

  def subject = I18n.t("weight_reminders.subject", pets: @dues.map { |due| name(due.pet) }.to_sentence)

  def lines
    @dues.map do |due|
      if due.last_weighed_on
        I18n.t("weight_reminders.last", pet: name(due.pet), date: "#{due.last_weighed_on.month}/#{due.last_weighed_on.day}",
                                        days: due.days_since)
      else
        I18n.t("weight_reminders.never", pet: name(due.pet))
      end
    end
  end

  def url
    options = { locale: I18n.locale, **ActionMailer::Base.default_url_options }
    routes = Rails.application.routes.url_helpers
    @dues.one? ? routes.pet_trackers_url(@dues.first.pet, **options) : routes.pets_url(**options)
  end

  private

  def name(pet) = ApplicationController.helpers.pet_display_name(pet)
end
