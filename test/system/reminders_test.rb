require "application_system_test_case"

# The owner sets how often the fountain is cleaned, sees when it's due on Today,
# and turns reminders on; the hourly job then emails it at 9am.
class RemindersTest < ApplicationSystemTestCase
  LOCALE = I18n.default_locale

  setup do
    @owner = users(:one)
    @household = households(:one)
    @fountain = @household.care_spots.create!(kind: :water_fountain, name: "Kitchen fountain")
  end

  def sign_in(user, lands_on:)
    visit new_session_url(locale: LOCALE)
    find("#email_address").set(user.email_address)
    find("#password").set("password123")
    click_on "Sign in"
    assert_selector "h1", text: lands_on, wait: 10 # the first page after sign-in can be slow when the whole suite runs
  end

  test "the owner sets a reminder interval, sees it due on Today and turns reminders on" do
    sign_in(@owner, lands_on: /cat list/i)
    visit household_url(locale: LOCALE)
    within("##{ActionView::RecordIdentifier.dom_id(@fountain)}") do
      find("select[aria-label='Reminder for fountain cleaned']").select("Twice a week")
      find("select[aria-label='Reminder for filter changed']").select("Custom")
      find("input[aria-label='Custom days for filter changed']").set("10")
      click_on "Save"
    end
    assert_text "Saved."
    assert_equal({ "cleaned" => 4, "filter_changed" => 10 }, @fountain.care_routines.pluck(:action, :every_days).to_h)

    visit today_url(locale: LOCALE)
    within("##{ActionView::RecordIdentifier.dom_id(@fountain)}") do
      assert_text "🧽 Fountain cleaned due in 4 days"
      assert_text "🔄 Filter changed due in 10 days"
      click_on "💧 Refilled"
    end
    assert_selector "#care_notice", text: "Kitchen fountain: refilled" # the tap's page refresh is done
    within("##{ActionView::RecordIdentifier.dom_id(@household, :reminders)}") do
      assert_text "Reminders: off"
      click_on "Turn on"
    end
    assert_text "Reminders on for"
    assert_selector "##{ActionView::RecordIdentifier.dom_id(@household, :reminders)}", text: "Reminders by email: on"
    assert @household.reload.owner_reminders_enabled?
  end
end
