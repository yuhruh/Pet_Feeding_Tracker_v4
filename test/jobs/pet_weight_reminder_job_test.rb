require "test_helper"

class PetWeightReminderJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper

  test "sends weight reminder when due and user is active (has recent current_sign_in_at)" do
    user = users(:one)
    pet = pets(:one)

    # Set user as active via current_sign_in_at
    user.update!(current_sign_in_at: 1.day.ago)

    # Clear other pets to avoid interfere
    user.pets.where.not(id: pet.id).destroy_all

    # Set last weighed date to exactly 14 days ago
    tracker = Tracker.create!(
      pet: pet,
      date: 14.days.ago.to_date,
      food_type: "kibble",
      brand: "Acana",
      description: "Chicken & wild prairie",
      amount: 10,
      weight: 10.0,
      created_at: 14.days.ago
    )

    assert_enqueued_emails 1 do
      PetWeightReminderJob.perform_now(user)
    end
  end

  test "sends weight reminder when due and user is a new user (has nil current_sign_in_at but recent created_at)" do
    user = users(:one)
    pet = pets(:one)

    # Set current_sign_in_at to nil, but created_at is recent (now)
    user.update!(current_sign_in_at: nil, created_at: Time.current)

    # Clear other pets to avoid interfere
    user.pets.where.not(id: pet.id).destroy_all

    # Set last weighed date to exactly 14 days ago
    tracker = Tracker.create!(
      pet: pet,
      date: 14.days.ago.to_date,
      food_type: "kibble",
      brand: "Acana",
      description: "Chicken & wild prairie",
      amount: 10,
      weight: 10.0,
      created_at: 14.days.ago
    )

    assert_enqueued_emails 1 do
      PetWeightReminderJob.perform_now(user)
    end
  end

  test "does not send weight reminder when user is truly inactive (both current_sign_in_at and created_at are > 3 days ago)" do
    user = users(:one)
    pet = pets(:one)

    # Both sign in and creation are old, making inactive_days > 3
    user.update!(current_sign_in_at: 5.days.ago, created_at: 5.days.ago)

    # Clear other pets to avoid interfere
    user.pets.where.not(id: pet.id).destroy_all

    tracker = Tracker.create!(
      pet: pet,
      date: 14.days.ago.to_date,
      food_type: "kibble",
      brand: "Acana",
      description: "Chicken & wild prairie",
      amount: 10,
      weight: 10.0,
      created_at: 14.days.ago
    )

    assert_enqueued_emails 0 do
      PetWeightReminderJob.perform_now(user)
    end
  end
end
