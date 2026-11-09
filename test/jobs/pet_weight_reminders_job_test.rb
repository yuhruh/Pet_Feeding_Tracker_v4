require "test_helper"
require "minitest/mock"

# The hourly scan for weight reminders. It used to be a scheduled rake command,
# and Rake::Task#invoke runs only once per worker process, so after the first
# day it did nothing until the next deploy.
class PetWeightRemindersJobTest < ActiveJob::TestCase
  TAIPEI = ActiveSupport::TimeZone["Asia/Taipei"]

  setup do
    @owner = users(:one)
    @pet = pets(:one)
    @owner.owned_pets.where.not(id: @pet.id).destroy_all
    @owner.update!(created_at: TAIPEI.local(2026, 8, 1))
    Tracker.create!(pet: @pet, date: Date.new(2026, 10, 1), food_type: "kibble", brand: "Acana", description: "Chicken",
                    amount: 10, weight: 4.2)
  end

  def run_at(date)
    travel_to(TAIPEI.local(date.year, date.month, date.day, 9, 10)) do
      @owner.sessions.create!(last_active_at: 1.hour.ago)
      PetWeightRemindersJob.perform_now
    end
  end

  def weight_reminders_for(user) = CareReminder.where(user: user).where("key LIKE 'weight:%'")

  test "runs every time in the same process, not only the first" do
    run_at(Date.new(2026, 10, 15))
    run_at(Date.new(2026, 10, 29))

    assert_equal 2, weight_reminders_for(@owner).count
  end

  test "only owners get them, not caregivers" do
    caregiver = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                             password: "password123", timezone: "Asia/Taipei", created_at: TAIPEI.local(2026, 8, 1))
    @pet.household.memberships.create!(user: caregiver, role: :caregiver, reminders_enabled: true)

    run_at(Date.new(2026, 10, 15))

    assert_equal 1, weight_reminders_for(@owner).count
    assert_empty weight_reminders_for(caregiver)
  end

  test "one owner's failure doesn't stop the others" do
    calls = []
    fails_first = lambda do |user|
      calls << user
      raise "boom" if calls.one?
    end

    PetWeightReminderJob.stub(:perform_now, fails_first) do
      assert_nothing_raised { PetWeightRemindersJob.perform_now }
    end
    assert_equal User.where(id: Household.joins(:pets).select(:owner_id)).count, calls.size
    assert_operator calls.size, :>, 1
  end
end
