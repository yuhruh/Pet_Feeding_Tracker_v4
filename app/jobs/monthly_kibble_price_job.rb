# Queues a price check for every pet fed kibble in the last 30 days.
class MonthlyKibblePriceJob < ApplicationJob
  queue_as :default

  def perform
    checked_on = Date.current
    pets = Pet.where(id: Tracker.kibble.where(date: 30.days.ago.to_date..).select(:pet_id))
    queued = 0

    pets.find_each do |pet|
      PetKibblePriceJob.perform_later(pet, checked_on)
      queued += 1
    end

    # Logged so the host's logs show whether the monthly run happened, and for how many pets.
    Rails.logger.info("[MonthlyKibblePriceJob] queued #{queued} kibble price #{'check'.pluralize(queued)} for pets fed kibble in the last 30 days")
  end
end
