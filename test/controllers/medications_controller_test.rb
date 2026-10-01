require "test_helper"

class MedicationsControllerTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @pet = pets(:one)
    log_in_as(@owner)
  end

  test "the owner adds, changes and stops a medication" do
    get pet_medications_url(@pet, **L)
    assert_response :success

    post pet_medications_url(@pet, **L), params: { medication: { name: "Clavamox", dose: "1 tablet", times: [ "20:00", "08:00", "", "" ], starts_on: Date.current } }
    med = @pet.medications.sole
    assert_equal [ "Clavamox", "1 tablet", %w[08:00 20:00] ], [ med.name, med.dose, med.times ]

    patch pet_medication_url(@pet, med, **L), params: { medication: { times: [ "", "", "", "" ], ends_on: Date.current + 7 } }
    assert med.reload.as_needed?
    assert_equal Date.current + 7, med.ends_on

    get pet_medications_url(@pet, **L)
    assert_select "##{ActionView::RecordIdentifier.dom_id(med)}", text: /Clavamox 1 tablet · as needed/

    delete pet_medication_url(@pet, med, **L)
    assert med.reload.stopped_at
    get pet_medications_url(@pet, **L)
    assert_select "##{ActionView::RecordIdentifier.dom_id(med)}", count: 0
    assert_match(/Clavamox 1 tablet · stopped/, response.body)
  end

  test "bad input is explained" do
    post pet_medications_url(@pet, **L), params: { medication: { name: "", times: [ "08:00" ], starts_on: Date.current } }
    assert_equal I18n.t("activerecord.errors.models.medication.attributes.name.blank"), flash[:alert]
    assert_empty @pet.medications
  end

  test "the pet profile links to it" do
    get pet_url(@pet, **L)
    assert_select "a[href='#{pet_medications_path(@pet)}']"
  end

  test "caregivers and others can't change the list" do
    mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                       password: "password123", timezone: "Asia/Taipei")
    households(:one).memberships.create!(user: mom, role: :caregiver)
    med = @pet.medications.create!(name: "Clavamox", times: [ "08:00" ])

    log_in_as(mom)
    get pet_medications_url(@pet, **L)
    assert_equal I18n.t("households.owner_only", petname: @pet.petname.capitalize), flash[:alert]
    post pet_medications_url(@pet, **L), params: { medication: { name: "x", starts_on: Date.current } }
    delete pet_medication_url(@pet, med, **L)

    log_in_as(users(:two))
    delete pet_medication_url(@pet, med, **L)
    assert_equal I18n.t("pets.not_found"), flash[:alert]

    assert_equal [ med ], @pet.medications.to_a
    assert_nil med.reload.stopped_at
  end
end
