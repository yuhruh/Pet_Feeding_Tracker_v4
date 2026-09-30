namespace :notifications do
  desc "Sends a notification to users to weigh their pets"
  task weigh_pets: :environment do
    User.where(id: Household.joins(:pets).select(:owner_id)).find_each do |user|
      PetWeightReminderJob.perform_later(user)
    end
  end
end
