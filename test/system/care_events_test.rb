require "application_system_test_case"

# The Today page in a browser: a caregiver taps, adds details, builds one water
# record with the checkboxes, changes a time and undoes a tap; the owner adds a
# feeding to trackers; the viewer link shows the records with no buttons.
class CareEventsTest < ApplicationSystemTestCase
  LOCALE = I18n.default_locale

  setup do
    @owner = users(:one)
    @household = households(:one)
    @pet = pets(:one)
    @pet.update!(petname: "Aji")
    @box = @household.care_spots.create!(kind: :litter_box, name: "Upstairs box", position: 0)
    @fountain = @household.care_spots.create!(kind: :water_fountain, name: "Kitchen fountain", position: 1)
    @bag = @household.dry_foods.create!(user: @owner, food_type: "Kibble", brand: "Aurora", description: "Duck", amount: 1500)
    @mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @mom, role: :caregiver)
  end

  def sign_in(user, lands_on:)
    visit new_session_url(locale: LOCALE)
    find("#email_address").set(user.email_address)
    find("#password").set("password123")
    click_on "Sign in"
    assert_selector "h1", text: lands_on, wait: 10 # the first page after sign-in can be slow when the whole suite runs
  end

  # Waits for a change the page doesn't show.
  def eventually(seconds: 5)
    deadline = Time.now + seconds
    until (result = yield) || Time.now > deadline
      sleep 0.1
    end
    result
  end

  def row(record) = find("##{ActionView::RecordIdentifier.dom_id(*Array(record))}")

  test "a caregiver records care, the owner adds it to trackers, a viewer sees it" do
    sign_in(@mom, lands_on: "Today")

    # Fed, then feeding details with a suggestion from the household's bags
    row([ @pet, :care ]).click_on "🍽 Fed"
    within("#care_notice") { assert_text "Aji: fed" }
    within("#care_notice") { click_on "Add details" }
    select "Kibble", from: "Food type"
    select "Aurora Duck (1500 g left)", from: "Suggestions"
    assert_field "Brand", with: "Aurora"
    fill_in "Amount (g)", with: "40"
    click_on "Save"
    assert_text "Aurora Duck · 40 g"
    fed = CareEvent.fed.sole
    assert_equal({ "food_type" => "kibble", "brand" => "Aurora", "description" => "Duck", "amount_g" => "40", "dry_food_id" => @bag.id.to_s }, fed.details)

    # Refilled, then the notice's checkboxes add the cleaning to the same record
    row(@fountain).click_on "💧 Refilled"
    assert_selector "#care_notice", text: "Kitchen fountain: refilled"
    within("#care_notice") { check "🧽 Fountain cleaned" }
    assert_text "Kitchen fountain: refilled, fountain cleaned"
    assert_equal %w[refilled cleaned], CareEvent.water.sole.actions

    # Scooped, then "10 min ago"
    row(@box).click_on "🚽 Scooped"
    assert_selector "#care_notice", text: "Upstairs box: scooped"
    within("#care_notice") { click_on "10 min ago" }
    scooped = CareEvent.litter.sole
    assert eventually { scooped.reload.occurred_at < 9.minutes.ago }, "the time moved back 10 minutes"

    # An accidental tap, undone
    row(@box).click_on "♻️ Full change"
    assert_selector "#care_notice", text: "Upstairs box: full change"
    within("#care_notice") { click_on "Undo" }
    assert_text "Undone."
    assert CareEvent.litter.order(:id).last.undone?

    # The owner adds Mom's feeding to trackers
    click_on "Sign out", match: :first
    sign_in(@owner, lands_on: /cat list/i)
    visit today_url(locale: LOCALE)
    within("##{ActionView::RecordIdentifier.dom_id(fed)}") { click_on "Add to trackers" }
    assert_field "tracker[brand]", with: "Aurora"
    select "💖 Yes, eat right away", from: "tracker[hungry]" # the owner adds what only they record
    click_on "Add a record for Aji", match: :first
    assert eventually { fed.reload.tracker_id }, "the feeding is linked to the new tracker"
    assert_equal fed.tracker, @pet.trackers.order(:id).last

    # The viewer link shows it all, with no buttons
    link = @household.viewer_links.create!(name: "Grandma", created_by: @owner)
    visit viewer_page_url(token: link.token, locale: LOCALE)
    within("#today_status") do
      assert_text "Kitchen fountain: refilled, fountain cleaned · Mom"
      assert_text "Aji: fed · Mom"
      assert_no_selector "button"
    end
  end
end
