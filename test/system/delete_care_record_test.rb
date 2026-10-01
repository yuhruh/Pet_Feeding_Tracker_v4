require "application_system_test_case"

# A caregiver deletes an accidental "Fed" from the timeline (checkpoint H3):
# after confirming, it's gone from her Today page and, live, from the owner's.
class DeleteCareRecordTest < ApplicationSystemTestCase
  LOCALE = I18n.default_locale

  setup do
    @owner = users(:one)
    @household = households(:one)
    @pet = pets(:one)
    @pet.update!(petname: "Aji")
    @mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @mom, role: :caregiver)
    @fed = CareEvent.create!(kind: :fed, pet: @pet, actor: @mom, occurred_at: 15.minutes.ago)
    # Live updates are jobs; run them as they come, like the worker does.
    @queue_adapter = ActiveJob::Base.queue_adapter
    ActiveJob::Base.queue_adapter = :inline
  end

  teardown { ActiveJob::Base.queue_adapter = @queue_adapter }

  def sign_in(user, lands_on:)
    visit new_session_url(locale: LOCALE)
    find("#email_address").set(user.email_address)
    find("#password").set("password123")
    click_on "Sign in"
    assert_selector "h1", text: lands_on, wait: 10 # the first page after sign-in can be slow when the whole suite runs
  end

  def entry = "##{ActionView::RecordIdentifier.dom_id(@fed)}"

  test "a caregiver deletes an accidental feeding and it disappears for everyone" do
    using_session(:owner) do
      sign_in(@owner, lands_on: /cat list/i)
      visit today_url(locale: LOCALE)
      assert_selector entry, text: "Aji: fed · Mom"
    end

    using_session(:mom) do
      sign_in(@mom, lands_on: "Today")
      dismiss_confirm(/Delete “Aji: fed” at/) { within(entry) { click_on "Delete" } }
      assert_selector entry
      accept_confirm(/removed from Today, the charts and reminders/) { within(entry) { click_on "Delete" } }
      assert_text "Deleted. Aji: fed at"
      assert_no_selector entry
      assert_text "Not fed yet today"
    end
    assert_equal @mom, @fed.reload.deleted_by

    using_session(:owner) do
      assert_no_selector entry, wait: 10
      assert_text "Not fed yet today"
    end
  end
end
