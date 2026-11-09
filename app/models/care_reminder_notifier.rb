# Sends one person their reminders for one household (checkpoints H, I), by one
# channel (see ReminderChannels): the Android app, else LINE, else email. In
# their language, with a link to the Today page.
class CareReminderNotifier
  include ReminderChannels

  def initialize(user, household, items)
    @user = user
    @household = household
    @items = items
  end

  # Returns the channel used: "android", "line" or "email".
  def deliver
    I18n.with_locale(locale) do
      return "android" if pushed_to_android?(title: subject, body: lines.join("\n"), url: today_url)
      return "line" if line_uid && pushed_by_line?([ subject, "", *lines, "", "#{I18n.t('care_reminders.open_today')} #{today_url}" ].join("\n"))

      CareReminderMailer.with(user: @user, subject: subject, lines: lines, today_url: today_url, locale: locale.to_s).reminders.deliver_later
      "email"
    end
  end

  def subject = I18n.t("care_reminders.subject", household: helpers.household_name(@household))

  def lines = @items.map { |item| line(item) }

  def today_url = Rails.application.routes.url_helpers.today_url(locale: I18n.locale, **ActionMailer::Base.default_url_options)

  private

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
