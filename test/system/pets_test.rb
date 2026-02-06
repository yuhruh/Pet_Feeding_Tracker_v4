require "application_system_test_case"

class PetsTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @pet = pets(:one)
    @pet.user = users(:one)
  end

  test "visiting the index" do
    sign_in_as @user
    assert_selector "h1", text: /#{@user.username}'s cat list/i
  end

  test "should create pet" do
    sign_in_as @user
    click_on "add a cat"

    fill_in "Birthday", with: @pet.birthday
    fill_in "Breed", with: @pet.breed
    select "♂️ Male", from: "Gender"
    fill_in "Petname", with: "New Pet Name"
    fill_in "pet_weight", with: @pet.weight
    click_on "Add a cat"

    assert_text "Cat was successfully created"
    visit pets_path
    assert_selector "h1", text: /#{@user.username}'s cat list/i
  end

  test "should update Pet" do
    sign_in_as @user
    visit pet_url(locale: I18n.default_locale, id: @pet.id)
    click_on "Edit #{@pet.petname.capitalize}'s Profile"

    fill_in "Birthday", with: @pet.birthday
    fill_in "Breed", with: @pet.breed
    select "♀️ Female", from: "Gender"
    fill_in "Petname", with: @pet.petname
    fill_in "pet_weight", with: @pet.weight
    click_on "Update #{@pet.petname.capitalize}'s profile"

    assert_text "Cat #{@pet.petname.capitalize} was successfully updated"
    click_on "Go to #{@user.username.capitalize}'s cats list"
  end

  test "should destroy Pet" do
    sign_in_as @user
    visit pet_url(locale: I18n.default_locale, id: @pet.id)
    accept_confirm { click_on "Destroy #{@pet.petname}'s profile and records" }

    assert_text "Cat #{@pet.petname} was successfully destroyed."
  end
end
