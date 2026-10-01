require "test_helper"

# Litter observations (checkpoint F): added on a litter record's details page,
# shown on the timeline, the viewer page and, with a cat, in that cat's history.
class LitterObservationsPagesTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    @pet = pets(:one)
    @pet.update!(petname: "aji")
    @umi = @household.pets.create!(user: @owner, petname: "umi", gender: "♀️ Female")
    @mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @mom, role: :caregiver)
    @box = @household.care_spots.create!(kind: :litter_box, name: "Upstairs box")
    @scooped = CareEvent.create!(kind: :litter, care_spot: @box, actions: [ "scooped" ], actor: @mom, occurred_at: 20.minutes.ago)
  end

  def observe(event = @scooped, pet_id: @pet.id, **details)
    patch care_event_url(event, **L), params: { pet_id: pet_id, details: { pee: "", poop_count: "", stool: "", unusual: [ "" ] }.merge(details) }
  end

  test "an old litter record shows as before, and its page offers the observations" do
    log_in_as(@mom)
    get today_url(**L)
    assert_select "##{dom_id(@scooped)}", text: /Upstairs box: scooped · Mom\s*Change/

    get edit_care_event_url(@scooped, **L)
    assert_select "#litter_observations select[name=pet_id] option", count: 3, message: "not sure, Aji and Umi"
    assert_select "#litter_observations select[name=pet_id] option[value='#{pets(:two).id}']", count: 0
    assert_select "#litter_observations select[name='details[pee]']"
    assert_select "#litter_observations input[name='details[poop_count]']"
    assert_select "#litter_observations select[name='details[stool]']"
    assert_select "#litter_observations input[type=checkbox][name='details[unusual][]']", count: 3
  end

  test "a caregiver adds observations and the cat; the timeline shows them" do
    log_in_as(@mom)
    observe(pee: "normal", poop_count: "2", stool: "soft")
    assert_equal "Saved.", flash[:notice]

    @scooped.reload
    assert_equal @pet, @scooped.pet
    assert_equal({ "pee" => "normal", "poop_count" => 2, "stool" => "soft" }, @scooped.details)
    assert_equal @box, @scooped.care_spot
    assert_equal @mom, @scooped.edited_by

    get today_url(**L)
    assert_select "##{dom_id(@scooped)}", text: /Upstairs box: scooped · Mom · Aji · pee normal · 2 poops · stool soft.*\(changed\)/m
    assert_select "##{dom_id(@scooped)} span.text-red-600.font-semibold", count: 0
  end

  test "diarrhea or something unusual stands out in red" do
    log_in_as(@mom)
    observe(pet_id: "", stool: "diarrhea", unusual: [ "", "blood" ])

    get today_url(**L)
    assert_select "##{dom_id(@scooped)} span.text-red-600.font-semibold", text: "stool diarrhea · blood"
  end

  test "observations can be cleared again" do
    @scooped.update!(pet: @pet, details: { stool: "soft" })
    log_in_as(@mom)
    observe(pet_id: "")

    @scooped.reload
    assert_nil @scooped.pet
    assert_empty @scooped.details
  end

  test "another household's cat and made-up values are refused" do
    log_in_as(@mom)
    observe(pet_id: pets(:two).id)
    assert_equal I18n.t("activerecord.errors.models.care_event.attributes.pet.other_household"), flash[:alert]
    assert_nil @scooped.reload.pet

    observe(stool: "green")
    assert_equal I18n.t("activerecord.errors.models.care_event.attributes.details.stool"), flash[:alert]
    assert_empty @scooped.reload.details
  end

  test "a cat can't be named on a feeding or a water record through the form" do
    fed = CareEvent.create!(kind: :fed, pet: @pet, actor: @mom, occurred_at: 5.minutes.ago)
    fountain = @household.care_spots.create!(kind: :water_fountain)
    refilled = CareEvent.create!(kind: :water, care_spot: fountain, actions: [ "refilled" ], actor: @mom, occurred_at: 5.minutes.ago)
    log_in_as(@mom)

    patch care_event_url(fed, **L), params: { pet_id: @umi.id }
    assert_equal @pet, fed.reload.pet
    patch care_event_url(refilled, **L), params: { pet_id: @umi.id, details: { stool: "soft" } }
    assert_nil refilled.reload.pet
    assert_empty refilled.details
  end

  test "the cat's history lists its litter observations from the last 30 days" do
    @scooped.update!(pet: @pet, details: { poop_count: 1, unusual: [ "large_clumps" ] }, note: "huge clump")
    CareEvent.create!(kind: :litter, care_spot: @box, actions: [ "full_change" ], actor: @owner, occurred_at: 1.hour.ago, pet: @umi, details: { stool: "hard" })
    CareEvent.create!(kind: :litter, care_spot: @box, actions: [ "scooped" ], actor: @owner, occurred_at: 2.hours.ago)
    old = CareEvent.create!(kind: :litter, care_spot: @box, actions: [ "scooped" ], actor: @owner, occurred_at: 1.day.ago, pet: @pet, details: { stool: "soft" })
    old.update_columns(occurred_at: 31.days.ago)

    [ @owner, @mom ].each do |person|
      log_in_as(person)
      get pet_trackers_url(@pet, **L)
      assert_response :success
      assert_select "#litter_observations li", count: 1
      assert_select "#litter_observations li", text: /Upstairs box: scooped · Mom · 1 poop · very large clumps\s*· huge clump/
      assert_select "#litter_observations .text-red-600", text: "1 poop · very large clumps"
      delete session_url(**L)
    end

    log_in_as(@owner)
    get pet_trackers_url(@umi, **L)
    assert_select "#litter_observations li", text: /full change · .* · stool hard/
  end

  test "a cat with no observations says so" do
    log_in_as(@owner)
    get pet_trackers_url(@pet, **L)
    assert_select "#litter_observations", text: /None in the last 30 days/
  end

  test "the viewer page shows the observations but not the note" do
    @scooped.update!(pet: @pet, details: { pee: "few" }, note: "private note")
    link = @household.viewer_links.create!(name: "Grandma", created_by: @owner)

    get viewer_page_url(token: link.token, **L)
    assert_select "##{dom_id(@scooped)}", text: /Upstairs box: scooped · Mom · Aji · pee few/
    assert_no_match "private note", response.body
  end

  test "deleting the cat keeps the box's record on the timeline, without the cat" do
    @scooped.update!(pet: @umi, details: { stool: "soft" })
    log_in_as(@owner)
    delete pet_url(@umi, **L)

    get today_url(**L)
    assert_select "##{dom_id(@scooped)}", text: /Upstairs box: scooped · Mom · stool soft/
  end
end
