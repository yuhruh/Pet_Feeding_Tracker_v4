require "application_system_test_case"

class VetVisitsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @pet = pets(:one)
  end

  test "creating a vet visit with purpose and waiting time" do
    sign_in_as @user
    visit new_pet_vet_visit_url(locale: I18n.default_locale, pet_id: @pet.id)

    fill_in "When to see the vet", with: Date.today
    fill_in "Consultation Time (minutes)", with: 30
    fill_in "Waiting Time (minutes)", with: 10
    select "Vaccination", from: "Purpose of Visit"
    fill_in "Questions prepared to ask the vet", with: "Is this cat eating enough?"

    click_on "Save Prepared Questions"

    assert_selector "h2", text: /Vet Visit Info/i
    assert_text "Vaccination"
    assert_text "30 mins"
    assert_text "10 mins"
    assert_text "Waiting time is included in the total consultation time above."
  end

  test "waiting time greater than consultation time shows a validation error" do
    sign_in_as @user
    visit new_pet_vet_visit_url(locale: I18n.default_locale, pet_id: @pet.id)

    fill_in "Consultation Time (minutes)", with: 10
    fill_in "Waiting Time (minutes)", with: 30
    fill_in "Questions prepared to ask the vet", with: "Is this cat eating enough?"

    click_on "Save Prepared Questions"

    assert_text "must be less than or equal to the consultation time"
  end
end
