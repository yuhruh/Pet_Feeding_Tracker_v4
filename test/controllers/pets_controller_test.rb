require "test_helper"

class PetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email_address: "example@email.com", password: "password", password_confirmation: "password", username: "John Doe", timezone: "Asia/Taiper")
    post session_url, params: { email_address: @user.email_address, password: "password" }
    @pet = pets(:one)
    @pet.user = users(:one)
  end

  test "should get index" do
    get pets_url
    assert_response :success
  end

  test "should get new" do
    get new_pet_url
    assert_response :success
  end

  test "should create pet" do
    assert_difference("Pet.count") do
      post pets_url, params: { pet: { birthday: @pet.birthday, breed: @pet.breed, gender: @pet.gender, petname: @pet.petname, user_id: @pet.user_id, weight: @pet.weight } }
    end

    assert_redirected_to pet_url(Pet.last, locale: I18n.default_locale)
  end

  test "should show pet" do
    get pet_url(@pet)
    assert_response :success
  end

  test "should get edit" do
    get edit_pet_url(@pet)
    assert_response :success
  end

  test "should update pet" do
    patch pet_url(@pet), params: { pet: { birthday: @pet.birthday, breed: @pet.breed, gender: @pet.gender, petname: @pet.petname, user_id: @pet.user_id, weight: @pet.weight } }
    assert_redirected_to pet_url(@pet, locale: I18n.default_locale)
  end

  test "should destroy pet" do
    assert_difference("Pet.count", -1) do
      delete pet_url(@pet)
    end

    assert_redirected_to pets_url
  end
end
