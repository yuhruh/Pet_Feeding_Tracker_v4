# Sends one person their reminders for one household (checkpoint H), by one
# channel: LINE if they signed in with LINE (email if the push fails), else
# email. In their language, with a link to the Today page.
class CareReminderNotifier
  LOCALE_BY_TIME_ZONE = KibblePriceMailer::LOCALE_BY_TIME_ZONE

  def self.push_line(uid, text)
    response = line_bot_client.push_message(uid, { type: "text", text: text })
    response.is_a?(Net::HTTPSuccess)
  end

  def initialize(user, household, items)
    @user = user
    @household = household
    @items = items
  end

  # Returns the channel used: "line" or "email".
  def deliver
    I18n.with_locale(locale) do
      return "line" if line_uid && pushed_by_line?

      CareReminderMailer.with(user: @user, subject: subject, lines: lines, today_url: today_url, locale: locale.to_s).reminders.deliver_later
      "email"
    end
  end

  def subject = I18n.t("care_reminders.subject", household: helpers.household_name(@household))

  def lines = @items.map { |item| line(item) }

  def today_url = Rails.application.routes.url_helpers.today_url(locale: I18n.locale, **ActionMailer::Base.default_url_options)

  private

  def locale = LOCALE_BY_TIME_ZONE.fetch(@user.timezone.to_s, I18n.default_locale)

  def line_uid = @user.connected_services.find { |service| service.provider == "line" }&.uid

  def pushed_by_line?
    self.class.push_line(line_uid, [ subject, "", *lines, "", "#{I18n.t('care_reminders.open_today')} #{today_url}" ].join("\n"))
  rescue StandardError => error
    Rails.error.report(error, handled: true, context: { user_id: @user.id })
    false
  end

  def line(item)
    case item.kind
    when :dose
      I18n.t("care_reminders.dose", pet: helpers.pet_display_name(item.medication.pet), medicine: item.medication.label, time: item.dose.time)
    else
      spot = item.routine.care_spot
      key = item.time ? "#{item.kind}_at" : item.kind
      I18n.t("care_reminders.#{key}", job: helpers.care_action_label(spot, item.routine.action), spot: helpers.care_spot_name(spot),
                                      time: item.time, last: last_text(item.last))
    end
  end

  def last_text(event)
    return I18n.t("care_reminders.never") unless event

    local = event.occurred_at.in_time_zone(@household.time_zone)
    I18n.t("care_reminders.last", date: "#{local.month}/#{local.day}", person: helpers.care_person(event.actor))
  end

  def helpers = ApplicationController.helpers
end
