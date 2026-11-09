# How a reminder reaches one person: by the one channel they chose (the Android
# app, LINE or email; see User#reminder_channel_choice). When the app or LINE
# was chosen and fails, the reminder goes by email instead, the email says why,
# and the problem is kept on the person for their profile page until a send by
# their choice works again. Shared by CareReminderNotifier and
# PetWeightReminderNotifier, which set @user.
module ReminderChannels
  extend ActiveSupport::Concern

  LOCALE_BY_TIME_ZONE = KibblePriceMailer::LOCALE_BY_TIME_ZONE

  class_methods do
    # :sent, :gone or :failed for one phone.
    def push_android(token, title:, body:, url:)
      FcmClient.new.deliver(token: token, title: title, body: body, url: url)
    end

    def push_line(uid, text)
      response = line_bot_client.push_message(uid, { type: "text", text: text })
      response.is_a?(Net::HTTPSuccess)
    end
  end

  private

  # Sends by the person's choice; yields the problem (nil when email was the
  # choice) for the caller to send the email. Returns the channel used.
  def deliver_by_choice(title:, body:, url:, line_text:)
    choice = @user.reminder_channel_choice
    problem = case choice
    when "android" then android_problem(title: title, body: body, url: url)
    when "line" then line_problem(line_text)
    end

    remember_problem(problem)
    return choice unless choice == "email" || problem

    yield problem
    "email"
  end

  def android_problem(title:, body:, url:)
    return "android_no_phone" if @user.device_tokens.none?

    "android_failed" unless pushed_to_android?(title: title, body: body, url: url)
  end

  def line_problem(text)
    return "line_not_connected" unless line_uid

    "line_failed" unless pushed_by_line?(text)
  end

  def remember_problem(problem)
    return if problem.nil? && @user.reminder_problem.nil?

    @user.update_columns(reminder_problem: problem, reminder_problem_at: problem && Time.current)
  end

  def locale = LOCALE_BY_TIME_ZONE.fetch(@user.timezone.to_s, I18n.default_locale)

  def line_uid = @user.connected_services.find { |service| service.provider == "line" }&.uid

  # Sent to at least one of the person's phones; phones whose token is gone are forgotten.
  def pushed_to_android?(title:, body:, url:)
    return false unless FcmClient.configured?

    results = @user.device_tokens.map do |device|
      result = self.class.push_android(device.token, title: title, body: body, url: url)
      result == :gone ? device.delete && :gone : result
    rescue StandardError => error
      Rails.error.report(error, handled: true, context: { user_id: @user.id })
      :failed
    end
    results.include?(:sent)
  end

  def pushed_by_line?(text)
    self.class.push_line(line_uid, text)
  rescue StandardError => error
    Rails.error.report(error, handled: true, context: { user_id: @user.id })
    false
  end
end
