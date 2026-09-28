require "test_helper"

class MonthlyKibblePriceJobTest < ActiveJob::TestCase
  setup do
    Tracker.delete_all
  end

  def feed(pet, food_type, date)
    pet.trackers.create!(date: date, food_type: food_type, brand: "曙光", description: "無穀滋養鴨肉食譜", amount: 30)
  end

  test "queues a check for each pet fed kibble in the last 30 days" do
    feed(pets(:one), "Kibble", 3.days.ago.to_date)
    feed(pets(:one), "Kibble", 4.days.ago.to_date)
    feed(pets(:two), "Kibble", 40.days.ago.to_date)
    feed(pets(:two), "Wet", 1.day.ago.to_date)

    assert_enqueued_jobs 1, only: PetKibblePriceJob do
      MonthlyKibblePriceJob.perform_now
    end
    assert_enqueued_with job: PetKibblePriceJob, args: [ pets(:one), Date.current ]
  end
end
