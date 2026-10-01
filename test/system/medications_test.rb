require "application_system_test_case"

# The owner sets up a medication; a caregiver confirms a dose with 💊, which is
# then no longer offered, and records a missed dose with a reason; the viewer
# link shows the statuses.
class MedicationsTest < ApplicationSystemTestCase
  LOCALE = I18n.default_locale

  setup do
    @owner = users(:one)
    @household = households(:one)
    @pet = pets(:one)
    @pet.update!(petname: "Aji")
    @mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @mom, role: :caregiver)
    now = Time.current.in_time_zone(@household.time_zone)
    @now_slot = now.strftime("%H:%M")
    # A second dose far from now, so the current one is offered first.
    @other_slot = (now + 12.hours).strftime("%H:%M")
  end

  def sign_in(user, lands_on:)
    visit new_session_url(locale: LOCALE)
    find("#email_address").set(user.email_address)
    find("#password").set("password123")
    click_on "Sign in"
    assert_selector "h1", text: lands_on, wait: 10 # the first page after sign-in can be slow when the whole suite runs
  end

  def meds_panel = find("##{ActionView::RecordIdentifier.dom_id(@pet, :meds)}")

  test "the owner adds a medication, a caregiver gives and misses doses, the viewer sees them" do
    sign_in(@owner, lands_on: /cat list/i)
    visit pet_medications_url(pet_id: @pet, locale: LOCALE)
    within("form[action$='/pets/#{@pet.id}/medications']") do
      find("[aria-label='Name']").set("Clavamox")
      find("[aria-label='Dose']").set("1 tablet")
    end
    page.execute_script(<<~JS)
      document.getElementById("new_medication_time_0").value = "#{@now_slot}";
      document.getElementById("new_medication_time_1").value = "#{@other_slot}";
    JS
    click_on "Add medication"
    assert_text "Clavamox added."
    assert_equal [ @now_slot, @other_slot ].sort, @pet.medications.sole.times

    click_on "Sign out", match: :first
    sign_in(@mom, lands_on: "Today")
    meds_panel.find("summary").click
    within(meds_panel) do
      assert_text "Give Aji Clavamox 1 tablet (#{@now_slot} dose)?"
      click_on "Given", match: :first
    end
    assert_selector "#care_notice", text: "Aji: Clavamox 1 tablet (#{@now_slot}), given"
    assert_text "#{@now_slot} given by Mom"

    meds_panel.find("summary").click
    within(meds_panel) { assert_no_text "(#{@now_slot} dose)" } # a recorded dose isn't offered again

    # The other dose: couldn't give, with a reason
    within(meds_panel) do
      find("select[name=reason]").select("spat it out")
      click_on "Couldn't give"
    end
    assert_selector "#care_notice", text: "couldn't give (spat it out)"
    assert_equal %w[couldnt_give given], CareEvent.meds.order(:dose_status).pluck(:dose_status)

    link = @household.viewer_links.create!(name: "Grandma", created_by: @owner)
    visit viewer_page_url(token: link.token, locale: LOCALE)
    within("#today_status") do
      assert_text "#{@now_slot} given by Mom"
      assert_text "#{@other_slot} couldn't give (spat it out)"
      assert_no_selector "button"
    end
  end
end
