# How a reminder reaches one person (checkpoint I): the Android app if they have
# it signed in and push is set up, else LINE if they signed in with LINE, else
# email; a channel that fails falls through to the next. Shared by
# CareReminderNotifier and PetWeightReminderNotifier, which set @user.
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
