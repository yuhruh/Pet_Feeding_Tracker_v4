require "test_helper"

class VetVisitTest < ActiveSupport::TestCase
  setup do
    @pet = pets(:one)
    @user = users(:one)
    @other_user = users(:two)
  end

  test "valid vet visit" do
    visit = VetVisit.new(
      pet: @pet,
      question: "Is this cat eating enough?",
      visit_date: Date.today
    )
    assert visit.valid?
  end

  test "invalid without question" do
    visit = VetVisit.new(
      pet: @pet,
      visit_date: Date.today
    )
    assert_not visit.valid?
  end

  test "invalid without visit_date" do
    visit = VetVisit.new(
      pet: @pet,
      question: "Is this cat eating enough?"
    )
    assert_not visit.valid?
  end

  test "answered_date is set automatically on save when answer is present" do
    visit = VetVisit.create!(
      pet: @pet,
      question: "Is this cat eating enough?",
      visit_date: Date.today,
      answer: "Yes, she is perfectly healthy."
    )
    assert_equal Date.today, visit.answered_date
  end

  test "answered_date is nil if answer is cleared" do
    visit = VetVisit.create!(
      pet: @pet,
      question: "Is this cat eating enough?",
      visit_date: Date.today,
      answer: "Yes, she is perfectly healthy."
    )
    assert_equal Date.today, visit.answered_date

    visit.update!(answer: "")
    assert_nil visit.answered_date
  end

  test "can associate members/shared users" do
    visit = VetVisit.create!(
      pet: @pet,
      question: "Is this cat eating enough?",
      visit_date: Date.today
    )
    visit.members << @other_user
    assert_includes visit.reload.members, @other_user
  end

  test "syncs vet_name and consultation_time to other visits on the same date for the same pet" do
    visit1 = VetVisit.create!(
      pet: @pet,
      question: "Question 1",
      visit_date: Date.today,
      vet_name: "Dr. Smith",
      consultation_time: 20
    )
    visit2 = VetVisit.create!(
      pet: @pet,
      question: "Question 2",
      visit_date: Date.today,
      vet_name: "Dr. Smith",
      consultation_time: 20
    )

    visit1.update!(vet_name: "Dr. Watson", consultation_time: 45)

    assert_equal "Dr. Watson", visit2.reload.vet_name
    assert_equal 45, visit2.consultation_time
  end
end
