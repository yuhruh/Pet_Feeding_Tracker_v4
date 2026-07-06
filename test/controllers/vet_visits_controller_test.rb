require "test_helper"

class VetVisitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = users(:one)
    @non_owner = users(:two)
    @pet = pets(:one) # owned by userone
    @vet_visit = VetVisit.create!(
      pet: @pet,
      question: "What is my cat's weight trend?",
      visit_date: Date.today
    )
  end

  test "owner should get index" do
    log_in_as(@owner)
    get pet_vet_visits_url(@pet)
    assert_response :success
  end

  test "non-owner member should get index but only see shared visits" do
    @vet_visit.members << @non_owner
    log_in_as(@non_owner)
    get pet_vet_visits_url(@pet)
    assert_response :success
  end

  test "non-owner non-member should be redirected on index" do
    log_in_as(@non_owner)
    get pet_vet_visits_url(@pet)
    assert_redirected_to pets_url(locale: I18n.default_locale)
  end

  test "owner should get new" do
    log_in_as(@owner)
    get new_pet_vet_visit_url(@pet)
    assert_response :success
  end

  test "non-owner should be redirected on new" do
    log_in_as(@non_owner)
    get new_pet_vet_visit_url(@pet)
    assert_redirected_to pets_url(locale: I18n.default_locale)
  end

  test "owner should create vet_visit and sync members" do
    log_in_as(@owner)
    assert_difference("VetVisit.count") do
      post pet_vet_visits_url(@pet), params: {
        vet_visit: {
          question: "How often should I feed dry food?",
          visit_date: Date.today,
          member_emails: [@non_owner.email_address]
        }
      }
    end
    assert_redirected_to pet_vet_visits_url(@pet, locale: I18n.default_locale)
    
    new_visit = VetVisit.last
    assert_includes new_visit.members, @non_owner
  end

  test "owner should get edit" do
    log_in_as(@owner)
    get edit_pet_vet_visit_url(@pet, @vet_visit)
    assert_response :success
  end

  test "member should get edit" do
    @vet_visit.members << @non_owner
    log_in_as(@non_owner)
    get edit_pet_vet_visit_url(@pet, @vet_visit)
    assert_response :success
  end

  test "non-member non-owner should be redirected on edit" do
    log_in_as(@non_owner)
    get edit_pet_vet_visit_url(@pet, @vet_visit)
    assert_redirected_to pets_url(locale: I18n.default_locale)
  end

  test "member should be able to update answer and question" do
    @vet_visit.members << @non_owner
    log_in_as(@non_owner)
    patch pet_vet_visit_url(@pet, @vet_visit), params: {
      vet_visit: {
        question: "Updated question?",
        answer: "This is the vet's answer."
      }
    }
    assert_redirected_to pet_vet_visits_url(@pet, locale: I18n.default_locale)
    @vet_visit.reload
    assert_equal "Updated question?", @vet_visit.question
    assert_equal "This is the vet's answer.", @vet_visit.answer
    assert_not_nil @vet_visit.answered_date
  end

  test "owner should destroy vet_visit" do
    log_in_as(@owner)
    assert_difference("VetVisit.count", -1) do
      delete pet_vet_visit_url(@pet, @vet_visit)
    end
    assert_redirected_to pet_vet_visits_url(@pet, locale: I18n.default_locale)
  end

  test "non-owner should not destroy vet_visit" do
    log_in_as(@non_owner)
    assert_no_difference("VetVisit.count") do
      delete pet_vet_visit_url(@pet, @vet_visit)
    end
    assert_redirected_to pets_url(locale: I18n.default_locale)
  end
end
