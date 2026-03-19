# frozen_string_literal: true

class NotificationService
  def initialize(user)
    @user = user
  end

  def send_pet_weight_reminder
    if line_user?
      send_line_notification
    else
      send_email_notification
    end
  end

  private

  def line_user?
    @user.connected_services.exists?(provider: "line")
  end

  def send_line_notification
    line_uid = @user.connected_services.find_by(provider: "line").uid
    message = {
      type: "text",
      text: "It's time to weigh your pet's weight!"
    }
    line_bot_client.push_message(line_uid, message)
  end

  def send_email_notification
    UserMailer.send_pet_weight_reminder(@user).deliver_now
  end
end
