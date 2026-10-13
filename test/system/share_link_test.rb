require "application_system_test_case"

# Creating a share link on the trackers page shows the new link, ready to copy.
class ShareLinkTest < ApplicationSystemTestCase
  LOCALE = I18n.default_locale

  test "the owner creates a new link and sees it, with a Copy button" do
    owner = users(:one)
    pet = pets(:one)
    visit new_session_url(locale: LOCALE)
    find("#email_address").set(owner.email_address)
    find("#password").set("password123")
    click_on "Sign in"
    assert_no_selector "#email_address", wait: 10

    visit pet_trackers_url(pet, locale: LOCALE)
    old_token = pet.share_token
    find("#share_settings summary").click
    select "30 days", from: "expires_in"
    accept_confirm { click_on "Create a new link" }

    assert_text "Share link is on."
    within("#share_settings") do
      assert_field "share_link_url", with: shared_pet_trackers_url(share_token: pet.reload.share_token, locale: LOCALE), visible: true
      assert_button "Copy"
    end
    assert_not_equal old_token, pet.share_token
  end
end
