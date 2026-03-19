class PetWeightReminderJob < ApplicationJob
  queue_as :default

  def perform(user)
    NotificationService.new(user).send_pet_weight_reminder
  end
end
