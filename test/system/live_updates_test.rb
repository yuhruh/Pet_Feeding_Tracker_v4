require "application_system_test_case"

# Live updates (checkpoint G), with three browsers open at once: a caregiver's
# taps appear on the owner's Today page and on a viewer page without reloading,
# and the owner's own saved notice stays open meanwhile.
class LiveUpdatesTest < ApplicationSystemTestCase
  LOCALE = I18n.default_locale

  setup do
    @owner = users(:one)
    @household = households(:one)
    @pet = pets(:one)
    @pet.update!(petname: "Aji")
    @mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @mom, role: :caregiver)
    @box = @household.care_spots.create!(kind: :litter_box, name: "Upstairs box")
    @link = @household.viewer_links.create!(name: "Grandma", created_by: @owner)
    # The refresh broadcasts are jobs; run them as they come, like the worker does.
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

  def row(record) = find("##{ActionView::RecordIdentifier.dom_id(*Array(record))}")

  # Set before the update; still there afterwards only if the page wasn't reloaded.
  def mark_page = page.execute_script("window.__notReloaded = true")
  def assert_not_reloaded = assert(page.evaluate_script("window.__notReloaded === true"), "the page was reloaded")

  test "a caregiver's taps appear on the owner's Today page and the viewer page without reloading" do
    using_session(:viewer) do
      visit viewer_page_url(token: @link.token, locale: LOCALE)
      assert_text "Nothing recorded in the last 24 hours."
      mark_page
    end

    using_session(:owner) do
      sign_in(@owner, lands_on: /cat list/i)
      visit today_url(locale: LOCALE)
      row([ @pet, :care ]).click_on "🍽 Fed"
      assert_selector "#care_notice", text: "Aji: fed"
      mark_page
    end

    using_session(:mom) do
      sign_in(@mom, lands_on: "Today")
      row(@box).click_on "🚽 Scooped"
      assert_selector "#care_notice", text: "Upstairs box: scooped"
    end

    using_session(:owner) do
      assert_selector "##{ActionView::RecordIdentifier.dom_id(CareEvent.litter.sole)}", text: "Upstairs box: scooped · Mom", wait: 10
      assert_text "scooped #{CareEvent.litter.sole.occurred_at.in_time_zone(@household.time_zone).strftime('%H:%M')} by Mom"
      assert_selector "#care_notice", text: "Aji: fed", visible: true # the owner's own notice stays open
      within("#care_notice") { assert_link "Add details" }
      assert_not_reloaded
    end

    using_session(:viewer) do
      within("#today_status") do
        assert_text "Upstairs box: scooped · Mom", wait: 10
        assert_text "Aji: fed · Userone"
        assert_no_selector "button"
      end
      assert_not_reloaded
    end

    # The caregiver's change of time reaches the others too.
    scooped = CareEvent.litter.sole
    moved = (scooped.occurred_at - 10.minutes).in_time_zone(@household.time_zone).strftime("%H:%M")
    using_session(:mom) do
      within("#care_notice") { click_on "10 min ago" }
      assert_selector "#care_notice", text: "Upstairs box: scooped · #{moved}"
    end
    using_session(:viewer) do
      assert_selector "##{ActionView::RecordIdentifier.dom_id(scooped)}", text: /#{moved}\s+🚽 Upstairs box: scooped · Mom \(changed\)/, wait: 10
      assert_not_reloaded
    end
  end
end
