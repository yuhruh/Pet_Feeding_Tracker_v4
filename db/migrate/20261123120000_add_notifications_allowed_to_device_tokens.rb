# Whether the phone shows Pet Tracker's notifications (allowed for the app and
# the "Reminders" channel on), as the Android app last reported. Reminders for
# phones that don't are emailed instead.
class AddNotificationsAllowedToDeviceTokens < ActiveRecord::Migration[8.1]
  def change
    add_column :device_tokens, :notifications_allowed, :boolean, default: true, null: false
  end
end
