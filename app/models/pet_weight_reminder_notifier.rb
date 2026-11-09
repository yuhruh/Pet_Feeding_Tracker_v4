# Tells one owner which of their pets are due a weighing, in one message by the
# channel they chose (see ReminderChannels). In their language, with a link to
# the pet's records (or the pet list for several).
class PetWeightReminderNotifier
  include ReminderChannels

  # dues: PetWeightReminders::Due, one per pet.
  def initialize(user, dues)
    @user = user
    @dues = dues
  end

  # Returns the channel used: "android", "line" or "email".
  def deliver
    I18n.with_locale(locale) do
      line_text = [ subject, "", *lines, "", "#{I18n.t('weight_reminders.open')} #{url}" ].join("\n")
      deliver_by_choice(title: subject, body: lines.join("\n"), url: url, line_text: line_text) do |problem|
        UserMailer.with(user: @user, subject: subject, lines: lines, url: url, locale: locale.to_s, problem: problem)
                  .send_pet_weight_reminder.deliver_later
      end
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
