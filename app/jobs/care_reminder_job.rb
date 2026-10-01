# Hourly (config/recurring.yml): sends what's due in every household where
# someone has reminders on (checkpoint H). See HouseholdReminders.
class CareReminderJob < ApplicationJob
  queue_as :default

  def perform
    ids = Household.where(owner_reminders_enabled: true).pluck(:id) |
          HouseholdMembership.caregiver.where(reminders_enabled: true).distinct.pluck(:household_id)
    Household.where(id: ids).includes(:owner).find_each { |household| HouseholdReminders.new(household).deliver }
  end
end
