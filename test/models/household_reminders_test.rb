require "test_helper"
require "minitest/mock"

# Sending reminders (checkpoint H): once at 9am in the person's time zone, one
# follow-up 2 days later, nothing once it's done; dose reminders once; only for
# the owner and caregivers who turned them on; LINE, else email.
class HouseholdRemindersTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper
  include ActionMailer::TestHelper

  TAIPEI = ActiveSupport::TimeZone["Asia/Taipei"]

  setup do
    @owner = users(:one)
    @household = households(:one)
    @pet = pets(:one)
    @pet.update!(petname: "aji")
    @mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @mom, role: :caregiver)
    @fountain = @household.care_spots.create!(kind: :water_fountain, name: "Kitchen fountain")
    @monday = Date.new(2026, 10, 5)
    # Set a week before: due on Monday (cleaned every 7 days, never recorded).
    @routine = @fountain.care_routines.create!(action: "cleaned", every_hours: 168, started_on: @monday - 7)
    @household.update!(owner_reminders_enabled: true)
  end

  def at(date, hour, minute = 0) = TAIPEI.local(date.year, date.month, date.day, hour, minute)

  def run_at(time)
    travel_to(time) { HouseholdReminders.new(@household.reload).deliver }
  end

  def emails_to(user) = enqueued_jobs.count { |job| job["job_class"] == "ActionMailer::MailDeliveryJob" && job["arguments"].to_s.include?(user.to_gid.to_s) }

  test "a due job is sent once at 9am, followed up once 2 days later, then nothing" do
    assert_empty run_at(at(@monday, 8, 55)), "not before 9am"
    assert_equal({ @owner => "email" }, run_at(at(@monday, 9, 5)))
    assert_empty run_at(at(@monday, 10, 5)), "once"
    assert_empty run_at(at(@monday + 1, 9, 5))
    assert_equal({ @owner => "email" }, run_at(at(@monday + 2, 9, 5)), "the follow-up")
    assert_empty run_at(at(@monday + 4, 9, 5))
    assert_empty run_at(at(@monday + 6, 9, 5))

    reminder = CareReminder.sole
    assert_equal [ @owner, @routine, @monday, "email" ], [ reminder.user, reminder.care_routine, reminder.due_on, reminder.channel ]
    assert_not_nil reminder.follow_up_sent_at
    assert_equal 2, emails_to(@owner)
  end

  test "nothing after 9pm, and nothing once the job is recorded; doing it early moves the date" do
    assert_empty run_at(at(@monday, 21, 5)), "not after 9pm"

    travel_to(at(@monday, 7)) { CareEvent.create!(kind: :water, care_spot: @fountain, actions: [ "cleaned" ], actor: @mom, occurred_at: Time.current) }
    assert_empty run_at(at(@monday, 9, 5)), "done this morning"
    assert_empty run_at(at(@monday + 6, 9, 5))
    assert_equal({ @owner => "email" }, run_at(at(@monday + 7, 9, 5)), "due again a week after it was done")
    assert_equal @monday + 7, CareReminder.sole.due_on
  end

  test "only people who turned reminders on, and never viewers" do
    @household.update!(owner_reminders_enabled: false)
    grandma = User.create!(username: "grandma", email_address: "grandma@example.com", email_address_confirmation: "grandma@example.com",
                           password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: grandma, role: :viewer, reminders_enabled: true)
    assert_empty run_at(at(@monday, 9, 5))

    @household.memberships.find_by(user: @mom).update!(reminders_enabled: true)
    assert_equal({ @mom => "email" }, run_at(at(@monday, 10, 5)))
    assert_equal 0, emails_to(grandma)
  end

  test "9am is the person's own time zone" do
    @owner.update_column(:timezone, "Europe/London")
    @household.update!(owner_reminders_enabled: false)
    @household.memberships.find_by(user: @mom).update!(reminders_enabled: true)
    @mom.update_column(:timezone, "Europe/London")
    # Monday 09:05 in Taipei is 02:05 in London: too early there.
    assert_empty run_at(at(@monday, 9, 5))
    assert_equal({ @mom => "email" }, run_at(at(@monday, 16, 5)))
  end

  test "someone who signed in with LINE gets it by LINE, and by email if LINE fails" do
    @owner.connected_services.create!(provider: "line", uid: "U123")
    pushed = []
    CareReminderNotifier.stub(:push_line, ->(uid, text) { pushed << [ uid, text ]; true }) do
      assert_equal({ @owner => "line" }, run_at(at(@monday, 9, 5)))
    end
    assert_equal "U123", pushed.sole.first
    assert_includes pushed.sole.last, "Kitchen fountain"
    assert_includes pushed.sole.last, "🧽"
    assert_includes pushed.sole.last, "/zh-TW/today", "in the person's language, with the Today link"
    assert_equal 0, emails_to(@owner)

    CareReminderNotifier.stub(:push_line, ->(*) { raise "LINE is down" }) do
      assert_equal({ @owner => "email" }, run_at(at(@monday + 2, 9, 5)), "the follow-up falls back to email")
    end
  end

  test "several things due go in one message" do
    @fountain.care_routines.create!(action: "filter_changed", every_hours: 336, started_on: @monday - 20)
    assert_equal({ @owner => "email" }, run_at(at(@monday, 9, 5)))
    assert_equal 1, emails_to(@owner)
    assert_equal 2, CareReminder.count
  end

  test "a dose not recorded an hour after its time is reminded once, any time of day" do
    @routine.destroy
    medication = @pet.medications.create!(name: "Clavamox", dose: "1 tablet", times: %w[08:00 22:00], starts_on: @monday - 1)
    assert_empty run_at(at(@monday, 8, 55)), "not before an hour has passed"
    assert_equal({ @owner => "email" }, run_at(at(@monday, 9, 5)))
    assert_empty run_at(at(@monday, 10, 5)), "once"
    assert_equal "dose:#{medication.id}:2026-10-05:08:00", CareReminder.sole.key

    travel_to(at(@monday, 22, 10)) { CareEvent.create!(kind: :meds, pet: @pet, medication: medication, dose_time: "22:00", dose_status: "given", actor: @mom, occurred_at: Time.current) }
    assert_empty run_at(at(@monday, 23, 5)), "recorded"
    assert_empty run_at(at(@monday + 1, 13, 5)), "this morning's dose is too long ago"
    assert_equal({ @owner => "email" }, run_at(at(@monday + 1, 9, 5)))
  end

  test "the hourly job goes through every household where someone has reminders on" do
    travel_to(at(@monday, 9, 5)) do
      assert_enqueued_emails(1) { CareReminderJob.perform_now }
      assert_no_enqueued_emails { CareReminderJob.perform_now }
    end
  end

  test "the email lists the reminders with a link to Today" do
    perform_enqueued_jobs { run_at(at(@monday, 9, 5)) }
    mail = ActionMailer::Base.deliveries.sole
    assert_equal [ @owner.email_address ], mail.to
    assert_includes mail.subject, "🔔"
    assert_includes mail.text_part.body.to_s, "Kitchen fountain"
    assert_includes mail.html_part.body.to_s, "/zh-TW/today"
  end

  # Checkpoint H2: a litter box scooped several times a day.
  def scoop(time) = travel_to(time) { CareEvent.create!(kind: :litter, care_spot: box, actions: [ "scooped" ], actor: @mom, occurred_at: Time.current) }
  def box = @box ||= @household.care_spots.create!(kind: :litter_box, name: "Upstairs box")

  test "twice a day: reminded when due, between 9am and 9pm, once, with one follow-up an interval later" do
    @routine.destroy
    travel_to(at(@monday, 6)) { box.care_routines.create!(action: "scooped", every_hours: 12, started_on: @monday) }
    scoop(at(@monday, 8))
    assert_empty run_at(at(@monday, 19, 55)), "not due before 20:00"
    assert_equal({ @owner => "email" }, run_at(at(@monday, 20, 5)))
    assert_empty run_at(at(@monday, 21, 5))
    assert_equal "routine:#{box.care_routines.sole.id}:2026-10-05T20:00", CareReminder.sole.key
    assert_empty run_at(at(@monday + 1, 7, 5)), "not before 9am"
    assert_equal({ @owner => "email" }, run_at(at(@monday + 1, 9, 5)), "the follow-up, 12 hours on, waited for 9am")
    assert_empty run_at(at(@monday + 1, 20, 5)), "then nothing until it's done"

    scoop(at(@monday + 1, 10))
    assert_empty run_at(at(@monday + 1, 22, 5)), "due again at 22:00, after 9pm"
    assert_equal({ @owner => "email" }, run_at(at(@monday + 2, 9, 5)), "so it's sent at 9am")
  end

  test "a scoop before the due time moves it" do
    @routine.destroy
    travel_to(at(@monday, 6)) { box.care_routines.create!(action: "scooped", every_hours: 12, started_on: @monday) }
    scoop(at(@monday, 8))
    scoop(at(@monday, 15))
    assert_empty run_at(at(@monday, 20, 5)), "15:00 + 12 hours is 03:00"
    assert_empty run_at(at(@monday + 1, 3, 5)), "overnight"
    assert_equal({ @owner => "email" }, run_at(at(@monday + 1, 9, 5)))
  end

  test "set times: reminded at each set time not done, at any hour, with one follow-up 2 hours later" do
    @routine.destroy
    box.care_routines.create!(action: "scooped", mode: "set_times", times: %w[07:00 22:00], started_on: @monday - 1)
    scoop(at(@monday - 1, 22, 10))
    assert_empty run_at(at(@monday, 6, 55))
    assert_equal({ @owner => "email" }, run_at(at(@monday, 7, 5)), "07:00, before 9am: the owner chose it")
    assert_empty run_at(at(@monday, 8, 5))
    assert_equal({ @owner => "email" }, run_at(at(@monday, 9, 5)), "the follow-up 2 hours later")
    assert_empty run_at(at(@monday, 11, 5))
    assert_equal [ "routine:#{box.care_routines.sole.id}:2026-10-05T07:00" ], CareReminder.pluck(:key)

    scoop(at(@monday, 21, 40))
    assert_empty run_at(at(@monday, 22, 5)), "21:40 counts for 22:00"
  end

  test "set times: a late scoop stops the follow-up, and a set time isn't sent after its window" do
    @routine.destroy
    box.care_routines.create!(action: "scooped", mode: "set_times", times: %w[08:00 20:00], started_on: @monday - 1)
    scoop(at(@monday - 1, 20, 0))
    assert_equal({ @owner => "email" }, run_at(at(@monday, 8, 5)))
    scoop(at(@monday, 9, 0))
    assert_empty run_at(at(@monday, 10, 5)), "done late, within 2 hours: no follow-up"
    # 20:00 isn't done, but the job doesn't run again until 23:00 (a pause):
    # its window closed at 22:00, so it isn't sent that late.
    assert_empty run_at(at(@monday, 23, 0))
    assert_equal 1, CareReminder.count
  end
end
