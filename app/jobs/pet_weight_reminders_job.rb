# Hourly (config/recurring.yml): sends what's due to every household owner with
# pets. See PetWeightReminders, which has the rules. A job class, not a rake task:
# Rake::Task#invoke runs only once per worker process, so a scheduled rake
# command stopped after the first day.
class PetWeightRemindersJob < ApplicationJob
  queue_as :default

  def perform
    User.where(id: Household.joins(:pets).select(:owner_id)).find_each do |user|
      PetWeightReminders.new(user).deliver
    rescue StandardError => error
      Rails.error.report(error, context: { user_id: user.id })
    end
  end
end
