require "test_helper"

class UserBackupJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper

  test "performs user backup job and enqueues email when user has recent trackers" do
    # Clear all existing trackers' updated_at/created_at so they don't count as recent
    Tracker.update_all(created_at: 2.days.ago, updated_at: 2.days.ago)

    user = users(:one)
    pet = pets(:one)
    
    # Create a tracker that is within the last 25 hours
    Tracker.create!(
      pet: pet,
      date: Date.current,
      food_type: "kibble",
      brand: "Acana",
      description: "Chicken & wild prairie",
      amount: 10,
      created_at: 12.hours.ago,
      updated_at: 12.hours.ago
    )

    assert_enqueued_emails 1 do
      UserBackupJob.perform_now
    end
  end

  test "performs user backup job and enqueues email when user has recently updated trackers" do
    # Clear all existing trackers so they don't count as recent
    Tracker.update_all(created_at: 2.days.ago, updated_at: 2.days.ago)

    user = users(:one)
    tracker = Tracker.first
    
    # Update tracker to have recently updated_at
    tracker.update_columns(updated_at: 12.hours.ago)

    assert_enqueued_emails 1 do
      UserBackupJob.perform_now
    end
  end

  test "does not enqueue email when user has no recent trackers" do
    # Clear any trackers created or updated in the last day
    Tracker.update_all(created_at: 2.days.ago, updated_at: 2.days.ago)

    assert_enqueued_emails 0 do
      UserBackupJob.perform_now
    end
  end
end
