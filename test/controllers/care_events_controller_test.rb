require "test_helper"

class CareEventsControllerTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    @pet = pets(:one)
    @box = @household.care_spots.create!(kind: :litter_box, name: "Upstairs box")
    @fountain = @household.care_spots.create!(kind: :water_fountain, name: "Kitchen fountain")
    @mom = member("mom", :caregiver)
    log_in_as(@mom)
  end

  def member(name, role)
    user = User.create!(username: name, email_address: "#{name}@example.com", email_address_confirmation: "#{name}@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: user, role: role)
    user
  end

  def tap_fed(pet = @pet, **extra) = post(care_events_url(**L), params: { pet_id: pet.id, kind: "fed", **extra })
  def tap_spot(spot, action, **extra) = post(care_events_url(**L), params: { care_spot_id: spot.id, care_action: action, **extra })

  test "Today shows the household's spots and cats with buttons for a caregiver" do
    get today_url(**L)

    assert_select "##{ActionView::RecordIdentifier.dom_id(@box)} button", text: "🚽 Scooped"
    assert_select "##{ActionView::RecordIdentifier.dom_id(@fountain)} button", text: "🔄 Filter changed"
    assert_select "##{ActionView::RecordIdentifier.dom_id(@pet, :care)} button", text: "🍽 Fed"
    assert_select "##{ActionView::RecordIdentifier.dom_id(@pet, :care)}", text: /Not fed yet today/
  end

  test "one tap saves fed now, by the caregiver, and Today shows the notice, status and timeline" do
    freeze_time do
      tap_fed
      event = CareEvent.sole
      assert_equal [ "fed", @mom, @pet, @household, Time.current ], [ event.kind, event.actor, event.pet, event.household, event.occurred_at ]
      assert_redirected_to today_url(**L)

      follow_redirect!
      assert_select "#care_notice", text: /#{@pet.petname.capitalize}: fed/i
      assert_select "#care_notice button", text: "Undo"
      assert_select "#care_notice button", text: "10 min ago"
      assert_select "##{ActionView::RecordIdentifier.dom_id(@pet, :care)}", text: /Fed \d\d:\d\d by Mom/
      assert_select "##{ActionView::RecordIdentifier.dom_id(event)}", text: /fed · Mom/
    end
  end

  test "a second tap soon after asks before recording again" do
    tap_fed
    tap_fed
    assert_equal 1, CareEvent.count
    follow_redirect!
    assert_select "#care_repeat", text: /Mom recorded .*fed.* Record it again/

    tap_fed(confirmed: 1)
    assert_equal 2, CareEvent.count
  end

  test "water: taps within 2 minutes build one record; the notice's checkboxes add and remove jobs" do
    tap_spot(@fountain, "refilled")
    tap_spot(@fountain, "cleaned")
    event = CareEvent.sole
    assert_equal %w[refilled cleaned], event.actions

    follow_redirect!
    assert_select "#care_notice input[type=checkbox][value=filter_changed]:not([checked])"
    patch care_event_url(event, **L), params: { care_actions: %w[refilled filter_changed], from_notice: 1 }
    assert_equal %w[refilled filter_changed], event.reload.actions
    assert event.edited?

    travel 3.minutes do
      tap_spot(@fountain, "refilled", confirmed: 1)
      assert_equal 2, CareEvent.count, "a later tap is a new record"
    end
  end

  test "litter: each job is its own record" do
    tap_spot(@box, "scooped")
    tap_spot(@box, "full_change")
    assert_equal [ [ "scooped" ], [ "full_change" ] ], CareEvent.order(:id).map(&:actions)
  end

  test "change time with a quick pick, and undo within 10 seconds" do
    tap_fed
    event = CareEvent.sole
    patch care_event_url(event, **L), params: { minutes_ago: 10, from_notice: 1 }
    assert_in_delta 10.minutes.ago, event.reload.occurred_at, 5

    post undo_care_event_url(event, **L)
    assert event.reload.undone?
    get today_url(**L)
    assert_select "##{ActionView::RecordIdentifier.dom_id(event)}", count: 0

    tap_fed(confirmed: 1)
    travel 11.seconds do
      post undo_care_event_url(CareEvent.kept.sole, **L)
      assert_not CareEvent.kept.sole.undone?
      assert_equal I18n.t("care_events.undo.too_late"), flash[:alert]
    end
  end

  test "weight is saved from the small form" do
    post care_events_url(**L), params: { pet_id: @pet.id, kind: "weight", value: "4.25" }
    assert_equal 4.25, CareEvent.sole.value.to_f

    post care_events_url(**L), params: { pet_id: @pet.id, kind: "weight", value: "90" }
    assert_equal I18n.t("activerecord.errors.models.care_event.attributes.value.weight_range"), flash[:alert]
  end

  test "the owner's trackers today show on the timeline, and count as fed" do
    @pet.trackers.create!(date: Time.current.in_time_zone(@household.time_zone).to_date, feed_time: "08:00", food_type: "Wet",
                          brand: "Ciao", description: "Tuna", amount: 40)
    get today_url(**L)
    assert_select "ol li", text: /ciao tuna · 40 g/i
    assert_select "##{ActionView::RecordIdentifier.dom_id(@pet, :care)}", text: /Fed .* by #{@owner.username.capitalize}/
  end

  test "another household's cat or spot, and a viewer, can't record anything" do
    other_spot = households(:two).care_spots.create!(kind: :litter_box)
    tap_fed(pets(:two))
    tap_spot(other_spot, "scooped")
    assert_equal I18n.t("care_events.not_found"), flash[:alert]

    log_in_as(member("gran", :viewer))
    tap_fed
    assert_equal I18n.t("care_events.not_allowed"), flash[:alert]
    get today_url(**L)
    assert_select "##{ActionView::RecordIdentifier.dom_id(@household)} button", text: "🍽 Fed", count: 0
    assert_empty CareEvent.all
  end

  test "an archived spot takes no taps" do
    @box.update!(archived_at: Time.current)
    tap_spot(@box, "scooped")
    assert_empty CareEvent.all
  end

  test "changing someone else's record, or after a day, is refused for a caregiver but not the owner" do
    owners = CareEvent.create!(kind: :fed, pet: @pet, actor: @owner, occurred_at: 1.hour.ago)
    patch care_event_url(owners, **L), params: { minutes_ago: 5 }
    assert_equal I18n.t("care_events.not_allowed"), flash[:alert]

    tap_fed(confirmed: 1)
    moms = CareEvent.find_by!(actor: @mom)
    travel 25.hours do
      patch care_event_url(moms, **L), params: { note: "x" }
      assert_nil moms.reload.note
      log_in_as(@owner)
      patch care_event_url(moms, **L), params: { note: "ate half" }
      assert_equal "ate half", moms.reload.note
    end
  end

  test "a tampered request can't choose the household, person, cat, spot or tracker" do
    other_tracker = pets(:two).trackers.create!(date: Date.current, feed_time: "08:00", food_type: "Wet", brand: "x", description: "xx", amount: 1)
    tap_fed(household_id: households(:two).id, actor_id: @owner.id, care_spot_id: @box.id)
    event = CareEvent.sole
    assert_equal [ @household, @mom, @pet, nil ], [ event.household, event.actor, event.pet, event.care_spot ]

    patch care_event_url(event, **L), params: { household_id: households(:two).id, pet_id: pets(:two).id, care_spot_id: @box.id,
                                                tracker_id: other_tracker.id, actor_id: @owner.id, kind: "weight", note: "ok" }
    event.reload
    assert_equal [ @household, @mom, @pet, nil, nil, "fed", "ok" ],
                 [ event.household, event.actor, event.pet, event.care_spot, event.tracker, event.kind, event.note ]
  end
end
