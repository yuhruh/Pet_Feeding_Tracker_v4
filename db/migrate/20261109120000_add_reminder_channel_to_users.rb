# How each person gets reminders (weight and household): their choice of the
# Android app, LINE or email, and the last time the app or LINE failed and the
# reminder was emailed instead, for their profile page.
class AddReminderChannelToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :reminder_channel, :string
    add_column :users, :reminder_problem, :string
    add_column :users, :reminder_problem_at, :datetime
  end
end
