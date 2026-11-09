require "test_helper"
require "minitest/mock"

# Weight reminders: 14 days after the last weighing (or after the pet was added)
# and every 14 days after that, once each, made up by a later run if one is
# missed; between 9am and 9pm in the owner's time zone; only for active owners;
# the Android app, else LINE, else email.
class PetWeightReminderJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper

  TAIPEI = ActiveSupport::TimeZone["Asia/Taipei"]

  setup do
    @user = users(:one) # Asia/Taipei
    @pet = pets(:one)
    @pet.update!(petname: "aji", created_at: TAIPEI.local(2026, 8, 1))
    @user.owned_pets.where.not(id: @pet.id).destroy_all
    @user.sessions.destroy_all
    @weighed_on = Date.new(2026, 10, 1)
  end

  def at(date, hour = 9, minute = 10) = TAIPEI.local(date.year, date.month, date.day, hour, minute)

  # Runs the job at a time; returns the channel recorded, or nil if nothing was sent.
  def run_at(time)
    before = CareReminder.maximum(:id).to_i
    travel_to(time) do
      @user.sessions.create!(last_active_at: 1.hour.ago) if @visiting
      PetWeightReminderJob.perform_now(@user.reload)
    end
    CareReminder.where("id > ?", before).pick(:channel)
  end

  def day(n) = at(@weighed_on + n)

  test "sends on day 14 after weighing, once, and records it" do
    active_user
    weighed(@weighed_on)

    assert_nil run_at(day(13))
    assert_enqueued_emails(1) { assert_equal "email", run_at(day(14)) }
    assert_nil run_at(at(@weighed_on + 14, 15)), "once a period, even with hourly runs"
    reminder = CareReminder.sole
    assert_equal "weight:#{@pet.id}:2026-10-01:1", reminder.key
    assert_equal @weighed_on + 14, reminder.due_on
    assert_equal @pet.household, reminder.household
  end

  test "a missed day 14 is made up on the next run" do
    active_user
    weighed(@weighed_on)

    assert_equal "email", run_at(day(15))
    assert_nil run_at(day(16))
  end

  test "sends again every 14 days while the pet isn't weighed" do
    active_user
    weighed(@weighed_on)

    assert_equal "email", run_at(day(14))
    assert_nil run_at(day(21))
    assert_equal "email", run_at(day(28))
    assert_equal 2, CareReminder.count
  end

  test "weighing again starts a new count" do
    active_user
    weighed(@weighed_on)
    assert_equal "email", run_at(day(14))

    weighed(@weighed_on + 20)
    assert_nil run_at(day(28)), "only 8 days since the new weighing"
    assert_equal "email", run_at(day(34))
  end

  test "a pet never weighed is counted from when it was added" do
    @pet.trackers.update_all(weight: nil) # the fixture's record has a weight
    @pet.update!(created_at: at(@weighed_on, 20))
    active_user

    assert_nil run_at(day(13))
    assert_equal "email", run_at(day(14))
    assert_equal "weight:#{@pet.id}:2026-10-01:1", CareReminder.sole.key
    assert_match(/no weight recorded/, PetWeightReminderNotifier.new(@user, [ never_weighed ]).lines.first)
  end

  test "sends only between 9am and 9pm in the owner's time zone" do
    active_user
    weighed(@weighed_on)

    assert_nil run_at(at(@weighed_on + 14, 8, 59))
    assert_nil run_at(at(@weighed_on + 14, 21, 0))
    assert_equal "email", run_at(at(@weighed_on + 14, 9, 0))
  end

  test "days are counted in the owner's time zone, not UTC" do
    @user.update!(timezone: "America/Los_Angeles")
    active_user
    weighed(@weighed_on)
    los_angeles = ActiveSupport::TimeZone["America/Los_Angeles"]

    # 8pm on day 13 in Los Angeles is already day 14 in UTC.
    assert_nil run_at(los_angeles.local(2026, 10, 14, 20))
    assert_equal "email", run_at(los_angeles.local(2026, 10, 15, 9, 10))
  end

  test "sends to a user active through a session, even with an old sign-in" do
    @user.update!(current_sign_in_at: day(-6), created_at: day(-60))
    @user.sessions.create!(last_active_at: day(13))
    weighed(@weighed_on)

    assert_equal "email", run_at(day(14))
  end

  test "sends to a user who signed out but signed in recently" do
    @user.update!(current_sign_in_at: day(0), created_at: day(-60))
    weighed(@weighed_on)

    assert_equal "email", run_at(day(14))
  end

  test "sends to a new user who has never signed in" do
    @user.update!(current_sign_in_at: nil, created_at: day(0))
    weighed(@weighed_on)

    assert_equal "email", run_at(day(14))
  end

  test "nothing for an owner inactive for more than 15 days" do
    @user.update!(current_sign_in_at: day(0), created_at: day(-60))
    weighed(@weighed_on)

    assert_equal "email", run_at(day(14))
    assert_nil run_at(day(28)), "left after day 0: one reminder only"

    @user.sessions.create!(last_active_at: day(26))
    assert_nil run_at(day(42)), "16 days since the last visit"
  end

  test "two pets due get one message naming both" do
    active_user
    weighed(@weighed_on)
    other = Pet.create!(petname: "mochi", household: @pet.household, created_at: day(-10))
    weighed(@weighed_on, other)

    pushed = with_push { assert_equal "android", run_at(day(14)) }
    assert_equal 1, pushed.size
    assert_includes pushed.first[:title], "Aji"
    assert_includes pushed.first[:title], "Mochi"
    assert_equal 2, pushed.first[:body].lines.size
    assert_match %r{/zh-TW/pets\z}, pushed.first[:url]
    assert_equal 2, CareReminder.count
  end

  # Channels, as for household reminders.
  def with_push(result = :sent, &block)
    pushed = []
    push = ->(token, title:, body:, url:) { pushed << { token: token, title: title, body: body, url: url }; result }
    DeviceToken.register(user: @user, session: nil, token: "phone-1") unless @user.device_tokens.exists?
    FcmClient.stub(:configured?, true) { PetWeightReminderNotifier.stub(:push_android, push, &block) }
    pushed
  end

  test "the Android app first, in the owner's language, with a link to the pet's records" do
    active_user
    weighed(@weighed_on)
    @user.connected_services.create!(provider: "line", uid: "U123")

    pushed = PetWeightReminderNotifier.stub(:push_line, ->(*) { flunk "not by LINE" }) do
      with_push { assert_enqueued_emails(0) { assert_equal "android", run_at(day(14)) } }
    end
    assert_equal "⚖️ 該幫Aji量體重囉", pushed.first[:title]
    assert_includes pushed.first[:body], "10/1"
    assert_includes pushed.first[:body], "14"
    assert_match %r{/zh-TW/pets/#{@pet.id}/trackers\z}, pushed.first[:url]
  end

  test "a gone phone is forgotten and LINE is used; a LINE failure falls back to email" do
    active_user
    weighed(@weighed_on)
    @user.connected_services.create!(provider: "line", uid: "U123")
    texts = []

    PetWeightReminderNotifier.stub(:push_line, ->(uid, text) { texts << [ uid, text ]; true }) do
      with_push(:gone) { assert_equal "line", run_at(day(14)) }
    end
    assert_empty DeviceToken.all
    assert_equal "U123", texts.first.first
    assert_includes texts.first.last, "/zh-TW/pets/#{@pet.id}/trackers"

    PetWeightReminderNotifier.stub(:push_line, false) do
      assert_enqueued_emails(1) { assert_equal "email", run_at(day(28)) }
    end
  end

  test "the email is in the owner's language" do
    active_user
    weighed(@weighed_on)

    perform_enqueued_jobs { run_at(day(14)) }
    mail = ActionMailer::Base.deliveries.last
    assert_equal "⚖️ 該幫Aji量體重囉", mail.subject
    assert_equal [ @user.email_address ], mail.to
    assert_includes mail.text_part.body.decoded, "記錄體重"
    assert_includes mail.html_part.body.decoded, "/zh-TW/pets/#{@pet.id}/trackers"
  end

  private

  # An owner who keeps visiting: a session active an hour before each run.
  def active_user
    @user.update!(current_sign_in_at: day(-60), created_at: day(-60))
    @visiting = true
  end

  def never_weighed = PetWeightReminderJob::Due.new(pet: @pet, last_weighed_on: nil, days_since: 14, due_on: @weighed_on + 14, key: "k")

  def weighed(date, pet = @pet)
    Tracker.create!(pet: pet, date: date, food_type: "kibble", brand: "Acana", description: "Chicken & wild prairie",
                    amount: 10, weight: 4.2)
  end
end
