require "test_helper"

class CareSpotsControllerTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    @box = @household.care_spots.create!(kind: :litter_box, position: 0)
    @bowl = @household.care_spots.create!(kind: :water_bowl, position: 1)
    log_in_as(@owner)
  end

  def ids_in_order = @household.care_spots.active.pluck(:id)

  test "the owner adds, renames, turns a bowl into a fountain, reorders and removes spots" do
    post household_care_spots_url(**L), params: { care_spot: { name: "Upstairs box", kind: "litter_box" } }
    upstairs = @household.care_spots.find_by!(name: "Upstairs box")
    assert_equal [ @box.id, @bowl.id, upstairs.id ], ids_in_order

    patch household_care_spot_url(@bowl, **L), params: { care_spot: { name: "Kitchen fountain", kind: "water_fountain" } }
    assert_equal [ "Kitchen fountain", "water_fountain" ], [ @bowl.reload.name, @bowl.kind ]
    patch household_care_spot_url(@box, **L), params: { care_spot: { kind: "water_bowl" } }
    assert @box.reload.litter_box?, "a litter box stays a litter box"

    patch move_household_care_spot_url(upstairs, **L), params: { direction: "up" }
    assert_equal [ @box.id, upstairs.id, @bowl.id ], ids_in_order
    patch move_household_care_spot_url(@box, **L), params: { direction: "up" }
    assert_equal [ @box.id, upstairs.id, @bowl.id ], ids_in_order, "the first stays first"

    CareEvent.create!(kind: :litter, care_spot: upstairs, actions: [ "scooped" ], actor: @owner, occurred_at: 1.hour.ago)
    delete household_care_spot_url(upstairs, **L)
    assert upstairs.reload.archived_at
    assert_equal [ @box.id, @bowl.id ], ids_in_order
    get today_url(**L)
    assert_select "##{ActionView::RecordIdentifier.dom_id(upstairs)}", count: 0
    assert_select "ol li", text: /Upstairs box: scooped/, message: "past records keep its name"
  end

  test "Today shows a renamed spot and a fountain's filter button" do
    @bowl.update!(kind: :water_fountain, name: "Kitchen fountain")
    get today_url(**L)
    assert_select "##{ActionView::RecordIdentifier.dom_id(@bowl)}", text: /Kitchen fountain/
    assert_select "##{ActionView::RecordIdentifier.dom_id(@bowl)} button", text: "🔄 Filter changed"
    assert_select "##{ActionView::RecordIdentifier.dom_id(@box)}", text: /Litter box/
  end

  test "a caregiver or another owner can't change the spots" do
    mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                       password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: mom, role: :caregiver)
    log_in_as(mom)
    delete household_care_spot_url(@box, **L)
    assert_nil @box.reload.archived_at

    log_in_as(users(:two))
    delete household_care_spot_url(@box, **L)
    assert_response :not_found
    assert_nil @box.reload.archived_at
  end
end
