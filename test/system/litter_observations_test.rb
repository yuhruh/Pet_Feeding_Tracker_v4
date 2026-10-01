require "application_system_test_case"

# A caregiver scoops, then adds what they saw and which cat; the timeline shows
# it (diarrhea and blood in red), the owner finds it in the cat's history, and the
# viewer link shows it without the note.
class LitterObservationsTest < ApplicationSystemTestCase
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
  end

  def sign_in(user, lands_on:)
    visit new_session_url(locale: LOCALE)
    find("#email_address").set(user.email_address)
    find("#password").set("password123")
    click_on "Sign in"
    assert_selector "h1", text: lands_on, wait: 10 # the first page after sign-in can be slow when the whole suite runs
  end

  test "a caregiver adds litter observations, the owner and the viewer see them" do
    sign_in(@mom, lands_on: "Today")
    find("##{ActionView::RecordIdentifier.dom_id(@box)}").click_on "🚽 Scooped"
    within("#care_notice") { click_on "Add details" }

    within("#litter_observations") do
      select "Aji", from: "Which cat (if known)"
      select "normal", from: "Pee clumps"
      fill_in "Poops", with: "2"
      select "diarrhea", from: "Stool"
      check "blood"
    end
    fill_in "Note", with: "a little blood"
    click_on "Save"

    assert_text "Saved."
    scooped = CareEvent.litter.sole
    assert_equal @pet, scooped.pet
    assert_equal({ "pee" => "normal", "poop_count" => 2, "stool" => "diarrhea", "unusual" => [ "blood" ] }, scooped.details)
    within("##{ActionView::RecordIdentifier.dom_id(scooped)}") do
      assert_text "Upstairs box: scooped · Mom · Aji · pee normal · 2 poops · stool diarrhea · blood"
      assert_selector ".text-red-600", text: "stool diarrhea · blood"
    end

    click_on "Sign out", match: :first
    sign_in(@owner, lands_on: /cat list/i)
    visit pet_trackers_url(pet_id: @pet, locale: LOCALE)
    within("#litter_observations") do
      assert_text "Upstairs box: scooped · Mom · pee normal · 2 poops · stool diarrhea · blood"
      assert_text "a little blood"
    end

    link = @household.viewer_links.create!(name: "Grandma", created_by: @owner)
    visit viewer_page_url(token: link.token, locale: LOCALE)
    assert_text "Aji · pee normal · 2 poops · stool diarrhea · blood"
    assert_no_text "a little blood"
  end
end
