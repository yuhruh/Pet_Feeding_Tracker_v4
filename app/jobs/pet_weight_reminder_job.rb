class PetWeightReminderJob < ApplicationJob
  queue_as :default

  def perform(user)
    needs_reminder = user.pets.any? do |pet|
      last_tracker = pet.trackers.where.not(weight: nil).order(date: :desc).first
      last_weighed_date = last_tracker&.date || pet.created_at.to_date

      inactive_days = user.current_sign_in_at ? (Date.current - user.current_sign_in_at.to_date).to_i : Float::INFINITY
      days_since = (Date.current - last_weighed_date).to_i
      days_since >= 14 && days_since % 7 == 0 && inactive_days <= 3
    end
    if needs_reminder
      NotificationService.new(user).send_pet_weight_reminder
    end
  end
end
