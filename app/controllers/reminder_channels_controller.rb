# How the signed-in person gets reminders: the Android app, LINE (only if they
# signed in with LINE) or email. See ReminderChannels.
class ReminderChannelsController < ApplicationController
  def update
    channel = params[:reminder_channel].to_s
    unless User::REMINDER_CHANNELS.include?(channel) && (channel != "line" || Current.user.line_connected?)
      return redirect_to users_path(anchor: "reminder-channel"), alert: t(".invalid")
    end

    # A new choice starts clean: an old problem was about the old one.
    Current.user.update!(reminder_channel: channel, reminder_problem: nil, reminder_problem_at: nil)
    redirect_to users_path(anchor: "reminder-channel"), notice: t(".notice", channel: t("users.reminder_channel.#{channel}"))
  end
end
