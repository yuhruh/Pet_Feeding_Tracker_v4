require "test_helper"

# "Add details" / "Change" on a care event, suggestions by food type, and the
# owner's "Add to trackers".
class CareEventDetailsTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    @pet = pets(:one)
    @mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @mom, role: :caregiver)
    @bag = @household.dry_foods.create!(user: @owner, food_type: "Kibble", brand: "曙光", description: "無穀滋養鴨肉", amount: 1500)
    @fed = CareEvent.create!(kind: :fed, pet: @pet, actor: @mom, occurred_at: 20.minutes.ago)
  end

  test "suggestions come from the cat's household, by food type" do
    @pet.trackers.create!(date: Date.current, feed_time: "08:00", food_type: "Wet", brand: "Ciao", description: "Tuna", amount: 40,
                          hungry: "💖 Yes, eat right away", love: "💕", favorite_score: 35)
    @pet.trackers.create!(date: Date.current, feed_time: "09:00", food_type: "Other", brand: "Chicken", description: "Boiled", amount: 10)
    households(:two).dry_foods.create!(user: users(:two), food_type: "Kibble", brand: "Other house", description: "bag", amount: 100)

    suggestions = FeedingSuggestions.new(@pet).by_food_type
    assert_includes suggestions["kibble"].map { |s| s[:brand] }, "曙光"
    assert_not_includes suggestions["kibble"].map { |s| s[:brand] }, "Other house"
    assert_includes suggestions["kibble"].map { |s| s[:dry_food_id] }, @bag.id
    assert_equal [ "ciao" ], suggestions["wet"].map { |s| s[:brand] }
    assert_equal [ "chicken" ], suggestions["other"].map { |s| s[:brand] }
    assert_empty suggestions["freeze_dried"]
  end

  test "a caregiver adds feeding details and changes the time on their own record" do
    log_in_as(@mom)
    get edit_care_event_url(@fed, **L)
    assert_response :success
    assert_select "[data-controller=care-details][data-care-details-options-value*='曙光']"

    local = 30.minutes.ago.in_time_zone(@household.time_zone)
    patch care_event_url(@fed, **L), params: { occurred_at: local.strftime("%Y-%m-%dT%H:%M"),
                                               details: { food_type: "kibble", brand: "曙光", description: "無穀滋養鴨肉", amount_g: "40", dry_food_id: @bag.id } }
    @fed.reload
    assert_equal({ "food_type" => "kibble", "brand" => "曙光", "description" => "無穀滋養鴨肉", "amount_g" => "40", "dry_food_id" => @bag.id.to_s }, @fed.details)
    assert_in_delta local, @fed.occurred_at, 60
    assert_equal @mom, @fed.edited_by

    get today_url(**L)
    assert_select "##{ActionView::RecordIdentifier.dom_id(@fed)}", text: /曙光 無穀滋養鴨肉 · 40 g.*\(changed\)/m
  end

  test "details can't point at another household's bag or go beyond the time limits" do
    log_in_as(@mom)
    patch care_event_url(@fed, **L), params: { details: { dry_food_id: dry_foods(:two).id } }
    assert_equal I18n.t("activerecord.errors.models.care_event.attributes.details.other_household_bag"), flash[:alert]

    patch care_event_url(@fed, **L), params: { occurred_at: 9.days.ago.in_time_zone(@household.time_zone).strftime("%Y-%m-%dT%H:%M") }
    assert_equal I18n.t("activerecord.errors.models.care_event.attributes.occurred_at.too_long_ago"), flash[:alert]
    assert_empty @fed.reload.details
  end

  test "a litter record's jobs can be changed on its page" do
    box = @household.care_spots.create!(kind: :litter_box)
    scooped = CareEvent.create!(kind: :litter, care_spot: box, actions: [ "scooped" ], actor: @mom, occurred_at: 1.hour.ago)
    log_in_as(@mom)
    get edit_care_event_url(scooped, **L)
    assert_select "input[type=checkbox][value=full_change]"

    patch care_event_url(scooped, **L), params: { care_actions: %w[scooped full_change] }
    assert_equal %w[scooped full_change], scooped.reload.actions
  end

  test "the owner adds a feeding to trackers, prefilled, and it then shows once" do
    @fed.update!(details: { food_type: "kibble", brand: "曙光", description: "無穀滋養鴨肉", amount_g: "40", dry_food_id: @bag.id })
    log_in_as(@owner)
    get today_url(**L)
    assert_select "a[href='#{new_pet_tracker_path(@pet, care_event_id: @fed.id)}']"

    get new_pet_tracker_url(@pet, care_event_id: @fed.id, **L)
    local = @fed.occurred_at.in_time_zone(@owner.timezone)
    assert_select "input[name='tracker[brand]'][value='曙光']"
    assert_select "input[name='tracker[amount]']" do |input|
      assert_equal 40, input.first["value"].to_f
    end
    assert_select "input[name='tracker[feed_time]'][value='#{local.strftime('%H:%M')}']"
    assert_select "input[name=care_event_id][value='#{@fed.id}']"

    post pet_trackers_url(@pet, **L), params: { care_event_id: @fed.id, tracker: { date: local.to_date, feed_time: local.strftime("%H:%M"), food_type: "kibble",
                                                                                  brand: "曙光", description: "無穀滋養鴨肉", amount: 40, dry_food_id: @bag.id } }
    tracker = @pet.trackers.order(:id).last
    assert_equal tracker, @fed.reload.tracker
    assert_equal 40, @bag.reload.total_ate_amount.to_i, "the bag's stock follows the tracker"

    get today_url(**L)
    assert_select "ol li", text: /無穀滋養鴨肉/, count: 1
    assert_select "a[href='#{new_pet_tracker_path(@pet, care_event_id: @fed.id)}']", count: 0
  end

  test "a caregiver gets no Add to trackers, and can't use one" do
    log_in_as(@mom)
    get today_url(**L)
    assert_select "a[href='#{new_pet_tracker_path(@pet, care_event_id: @fed.id)}']", count: 0
    get new_pet_tracker_url(@pet, care_event_id: @fed.id, **L)
    assert_equal I18n.t("households.owner_only", petname: @pet.petname.capitalize), flash[:alert]
  end

  test "someone outside the household can't open or change a record" do
    log_in_as(users(:two))
    get edit_care_event_url(@fed, **L)
    assert_equal I18n.t("care_events.not_found"), flash[:alert]
    patch care_event_url(@fed, **L), params: { note: "x" }
    assert_nil @fed.reload.note
  end
end
