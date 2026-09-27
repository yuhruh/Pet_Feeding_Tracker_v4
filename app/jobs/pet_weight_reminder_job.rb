class PetWeightReminderJob < ApplicationJob
  queue_as :default

  INACTIVE_AFTER = 15.days

  def perform(user)
    return if inactive?(user)

    needs_reminder = user.pets.any? do |pet|
      last_tracker = pet.trackers.where.not(weight: nil).order(date: :desc).first
      last_weighed_date = last_tracker&.date || pet.created_at.to_date

      days_since = (Date.current - last_weighed_date).to_i
      days_since >= 14 && days_since % 14 == 0
    end

    NotificationService.new(user).send_pet_weight_reminder if needs_reminder
  end

  private

  def inactive?(user)
    last_active = [
      user.sessions.maximum(:last_active_at),
      user.current_sign_in_at,
      user.created_at
    ].compact.max

    last_active < INACTIVE_AFTER.ago
  end
end
