require "test_helper"

class PetWeightReminderJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper

  setup do
    # A fixed 9am run, like the production schedule, so "N days ago" never straddles midnight
    travel_to Time.zone.local(2026, 9, 27, 9, 0, 0)

    @user = users(:one)
    @pet = pets(:one)

    # Clear other pets to avoid interfere
    @user.pets.where.not(id: @pet.id).destroy_all
    @user.sessions.destroy_all
  end

  teardown do
    travel_back
  end

  test "sends reminder when the user is active through a session, even with an old sign-in" do
    active_user(sign_in: 20.days.ago, session_active: 1.day.ago)
    weighed(14.days.ago)

    assert_enqueued_emails 1 do
      PetWeightReminderJob.perform_now(@user)
    end
  end

  test "sends reminder when the user signed out but signed in recently" do
    @user.update!(current_sign_in_at: 14.days.ago, created_at: 60.days.ago)
    weighed(14.days.ago)

    assert_enqueued_emails 1 do
      PetWeightReminderJob.perform_now(@user)
    end
  end

  test "sends reminder to a new user who has never signed in" do
    @user.update!(current_sign_in_at: nil, created_at: 14.days.ago)
    weighed(14.days.ago)

    assert_enqueued_emails 1 do
      PetWeightReminderJob.perform_now(@user)
    end
  end

  test "sends reminder again 28 days after weighing" do
    active_user
    weighed(28.days.ago)

    assert_enqueued_emails 1 do
      PetWeightReminderJob.perform_now(@user)
    end
  end

  test "does not send reminder on days between the 14-day marks" do
    active_user
    weighed(21.days.ago)

    assert_enqueued_emails 0 do
      PetWeightReminderJob.perform_now(@user)
    end
  end

  test "does not send reminder before 14 days" do
    active_user
    weighed(13.days.ago)

    assert_enqueued_emails 0 do
      PetWeightReminderJob.perform_now(@user)
    end
  end

  test "does not send reminder when the user is inactive" do
    @user.update!(current_sign_in_at: 20.days.ago, created_at: 20.days.ago)
    weighed(28.days.ago)

    assert_enqueued_emails 0 do
      PetWeightReminderJob.perform_now(@user)
    end
  end

  test "does not send reminder when the user was last active just past the threshold" do
    active_user(sign_in: 16.days.ago, session_active: 16.days.ago)
    weighed(14.days.ago)

    assert_enqueued_emails 0 do
      PetWeightReminderJob.perform_now(@user)
    end
  end

  private

  def active_user(sign_in: 1.day.ago, session_active: 1.day.ago)
    @user.update!(current_sign_in_at: sign_in, created_at: 60.days.ago)
    @user.sessions.create!(last_active_at: session_active)
  end

  def weighed(time)
    Tracker.create!(
      pet: @pet,
      date: time.to_date,
      food_type: "kibble",
      brand: "Acana",
      description: "Chicken & wild prairie",
      amount: 10,
      weight: 10.0,
      created_at: time
    )
  end
end
