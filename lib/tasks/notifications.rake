namespace :notifications do
  desc "Sends a notification to users to weigh their pets"
  task weigh_pets: :environment do
    User.joins(:pets).distinct.find_each do |user|
      PetWeightReminderJob.perform_later(user)
    end
  end
end
