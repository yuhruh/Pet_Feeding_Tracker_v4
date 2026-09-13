require "test_helper"

# Signed in as users(:one); every request targets pets(:two), which belongs to users(:two).
class PetOwnershipTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as(users(:one))
    @other_pet = pets(:two)
  end

  test "cannot view another user's pet" do
    get pet_url(@other_pet)
    assert_redirected_to pets_url(locale: I18n.default_locale)
    assert_equal I18n.t("pets.not_found"), flash[:alert]
  end

  test "cannot edit or update another user's pet" do
    get edit_pet_url(@other_pet)
    assert_redirected_to pets_url(locale: I18n.default_locale)

    patch pet_url(@other_pet), params: { pet: { petname: "Hacked" } }
    assert_redirected_to pets_url(locale: I18n.default_locale)
    assert_not_equal "Hacked", @other_pet.reload.petname
  end

  test "cannot delete another user's pet" do
    assert_no_difference("Pet.count") do
      delete pet_url(@other_pet)
    end
  end

  test "cannot list, export or rank another user's trackers" do
    get pet_trackers_url(@other_pet)
    assert_redirected_to pets_url(locale: I18n.default_locale)

    get favorite_food_pet_trackers_url(@other_pet)
    assert_redirected_to pets_url(locale: I18n.default_locale)

    get pet_trackers_url(@other_pet, format: :csv)
    assert_response :not_found
  end

  test "cannot create, delete or bulk delete another user's trackers" do
    tracker = trackers(:two)
    assert_no_difference("Tracker.count") do
      post pet_trackers_url(@other_pet), params: { tracker: { date: Date.today, food_type: "wet", brand: "Ciao", description: "Tuna", amount: 10 } }
      delete pet_tracker_url(@other_pet, tracker)
      delete bulk_delete_pet_trackers_url(@other_pet), params: { tracker_ids: [ tracker.id ] }
    end
  end

  test "cannot import trackers into another user's pet" do
    post import_pet_trackers_url(@other_pet)
    assert_redirected_to pets_url(locale: I18n.default_locale)
  end

  test "cannot list, view or delete another user's health checks" do
    health_check = health_checks(:two)
    get pet_health_checks_url(@other_pet)
    assert_redirected_to pets_url(locale: I18n.default_locale)

    get pet_health_check_url(@other_pet, health_check)
    assert_redirected_to pets_url(locale: I18n.default_locale)

    assert_no_difference("HealthCheck.count") do
      delete pet_health_check_url(@other_pet, health_check)
      delete bulk_delete_pet_health_checks_url(@other_pet), params: { health_check_ids: [ health_check.id ] }
    end
  end

  test "cannot run photo extraction on another user's pet" do
    post extract_data_pet_health_checks_url(@other_pet), as: :json
    assert_response :not_found
  end
end

class PetOwnershipSignedOutTest < ActionDispatch::IntegrationTest
  test "signed-out visitor is sent to login instead of an error" do
    locale = I18n.default_locale

    get pet_url(pets(:one), locale: locale)
    assert_redirected_to new_session_url(locale: locale)

    get pet_trackers_url(pets(:one), locale: locale)
    assert_redirected_to new_session_url(locale: locale)

    get pet_health_checks_url(pets(:one), locale: locale)
    assert_redirected_to new_session_url(locale: locale)
  end
end
