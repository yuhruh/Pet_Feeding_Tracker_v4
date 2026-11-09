namespace :notifications do
  # For running by hand. The schedule runs PetWeightRemindersJob directly
  # (config/recurring.yml); see that job for why it isn't this task.
  desc "Sends weight reminders that are due now"
  task weigh_pets: :environment do
    PetWeightRemindersJob.perform_now
  end
end
