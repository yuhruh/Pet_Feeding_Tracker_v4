require "test_helper"

class CareEventTest < ActiveSupport::TestCase
  setup do
    @household = households(:one)
    @owner = users(:one)
    @pet = pets(:one)
    @box = @household.care_spots.create!(kind: :litter_box)
    @fountain = @household.care_spots.create!(kind: :water_fountain, name: "Kitchen fountain")
  end

  def event(**attributes)
    CareEvent.new({ actor: @owner, occurred_at: Time.current }.merge(attributes))
  end

  test "the household comes from the cat or spot, whatever is given" do
    fed = event(kind: :fed, pet: @pet, household: households(:two))
    assert fed.save
    assert_equal @household, fed.household

    scooped = event(kind: :litter, care_spot: @box, actions: [ "scooped" ])
    assert scooped.save
    assert_equal @household, scooped.household
  end

  test "each kind needs its own subject and actions" do
    assert_not event(kind: :fed, care_spot: @box).valid?
    assert_not event(kind: :litter, pet: @pet, actions: [ "scooped" ]).valid?
    assert_not event(kind: :litter, care_spot: @fountain, actions: [ "scooped" ]).valid?, "a fountain isn't a litter box"
    assert_not event(kind: :water, care_spot: @box, actions: [ "refilled" ]).valid?
    assert_not event(kind: :water, care_spot: @fountain, actions: []).valid?
    assert_not event(kind: :water, care_spot: @household.care_spots.create!(kind: :water_bowl), actions: [ "filter_changed" ]).valid?,
               "a bowl has no filter"
    assert event(kind: :water, care_spot: @fountain, actions: %w[refilled cleaned filter_changed]).valid?
    assert_not event(kind: :fed, pet: @pet, actions: [ "scooped" ]).valid?
  end

  test "times: at most 2 minutes ahead and 7 days back" do
    assert_not event(kind: :fed, pet: @pet, occurred_at: 5.minutes.from_now).valid?
    assert event(kind: :fed, pet: @pet, occurred_at: 1.minute.from_now).valid?
    assert event(kind: :fed, pet: @pet, occurred_at: 6.days.ago).valid?
    assert_not event(kind: :fed, pet: @pet, occurred_at: 8.days.ago).valid?
  end

  test "feeding details are optional, checked, and a food bag must be the cat's household's" do
    assert event(kind: :fed, pet: @pet, details: { food_type: "kibble", brand: "曙光", amount_g: "40", dry_food_id: dry_foods(:one).id }).valid?
    assert_not event(kind: :fed, pet: @pet, details: { dry_food_id: dry_foods(:two).id }).valid?, "another household's bag"
    assert_not event(kind: :fed, pet: @pet, details: { food_type: "pizza" }).valid?
    assert_not event(kind: :fed, pet: @pet, details: { amount_g: "-3" }).valid?
    assert_equal({ "brand" => "x" }, event(kind: :fed, pet: @pet, details: { brand: "x", secret: "y", description: "" }).tap(&:valid?).details)
    assert_not event(kind: :litter, care_spot: @box, actions: [ "scooped" ], details: { brand: "x" }).valid?
  end

  test "weight is a sensible number of kilograms, only on weight records" do
    assert event(kind: :weight, pet: @pet, value: 4.2).valid?
    assert_not event(kind: :weight, pet: @pet, value: 0).valid?
    assert_not event(kind: :weight, pet: @pet, value: 80).valid?
    assert_not event(kind: :fed, pet: @pet, value: 4).valid?
  end

  test "a tracker linked to a feeding must be the same cat's" do
    other = pets(:two).trackers.create!(date: Date.current, feed_time: "08:00", food_type: "Wet", brand: "x", description: "xx", amount: 1)
    assert_not event(kind: :fed, pet: @pet, tracker: other).valid?
  end

  test "recent repeats: the same care on the same cat or spot, not undone" do
    first = event(kind: :fed, pet: @pet, occurred_at: 10.minutes.ago).tap(&:save!)
    assert_equal first, event(kind: :fed, pet: @pet).recent_repeat
    assert_nil event(kind: :fed, pet: pets(:two)).recent_repeat
    first.undo!
    assert_nil event(kind: :fed, pet: @pet).recent_repeat

    event(kind: :litter, care_spot: @box, actions: [ "scooped" ], occurred_at: 1.hour.ago).save!
    assert_nil event(kind: :litter, care_spot: @box, actions: [ "scooped" ]).recent_repeat, "scooping again an hour later is normal (H2)"
    event(kind: :litter, care_spot: @box, actions: [ "scooped" ], occurred_at: 20.minutes.ago).save!
    assert event(kind: :litter, care_spot: @box, actions: [ "scooped" ]).recent_repeat
    assert_nil event(kind: :litter, care_spot: @box, actions: [ "full_change" ]).recent_repeat, "a full change after scooping is normal"
    assert_nil event(kind: :weight, pet: @pet, value: 4).recent_repeat
  end

  test "who may undo and change a record" do
    mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                       password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: mom, role: :caregiver)
    gran = User.create!(username: "gran", email_address: "gran@example.com", email_address_confirmation: "gran@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: gran, role: :viewer)
    moms = event(kind: :fed, pet: @pet, actor: mom).tap(&:save!)

    assert moms.undoable_by?(mom)
    assert_not moms.undoable_by?(@owner), "only the one who tapped"
    assert_not moms.undoable_by?(mom, now: 11.seconds.from_now)
    assert moms.editable_by?(mom) && moms.editable_by?(@owner)
    assert_not moms.editable_by?(mom, now: 25.hours.from_now)
    assert moms.editable_by?(@owner, now: 25.hours.from_now)
    assert_not moms.editable_by?(gran)
    assert_not event(kind: :fed, pet: @pet).tap(&:save!).editable_by?(mom), "not someone else's"
    assert_not moms.editable_by?(users(:two))
  end

  test "records go with their cat, household, and a deleted member" do
    mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                       password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: mom, role: :caregiver)
    moms = event(kind: :litter, care_spot: @box, actions: [ "scooped" ], actor: mom).tap(&:save!)
    mom.destroy!
    assert_nil moms.reload.actor

    event(kind: :fed, pet: @pet).save!
    assert_difference -> { CareEvent.count }, -2 do
      @owner.destroy!
    end
  end

  test "litter observations are optional, checked, and tidied" do
    scooped = event(kind: :litter, care_spot: @box, actions: [ "scooped" ],
                    details: { pee: "normal", poop_count: "2", stool: "soft", unusual: [ "", "other", "blood" ] })
    assert scooped.save
    assert_equal({ "pee" => "normal", "poop_count" => 2, "stool" => "soft", "unusual" => %w[blood other] }, scooped.details)
    assert scooped.observations?
    assert scooped.observation_warning?

    assert_equal({ "poop_count" => 0 }, event(kind: :litter, care_spot: @box, actions: [ "scooped" ], details: { poop_count: "0" }).tap(&:valid?).details)
    assert_equal({}, event(kind: :litter, care_spot: @box, actions: [ "scooped" ], details: { pee: "", stool: "", unusual: [ "" ] }).tap(&:valid?).details)
    assert_not event(kind: :litter, care_spot: @box, actions: [ "scooped" ]).observations?, "an old record has none"
    assert_not event(kind: :litter, care_spot: @box, actions: [ "scooped" ], details: { stool: "soft" }).observation_warning?
    assert event(kind: :litter, care_spot: @box, actions: [ "scooped" ], details: { stool: "diarrhea" }).observation_warning?

    assert_not event(kind: :litter, care_spot: @box, actions: [ "scooped" ], details: { pee: "lots" }).valid?
    assert_not event(kind: :litter, care_spot: @box, actions: [ "scooped" ], details: { stool: "green" }).valid?
    assert_not event(kind: :litter, care_spot: @box, actions: [ "scooped" ], details: { unusual: [ "worms" ] }).valid?
    assert_not event(kind: :litter, care_spot: @box, actions: [ "scooped" ], details: { poop_count: "11" }).valid?
    assert_not event(kind: :litter, care_spot: @box, actions: [ "scooped" ], details: { poop_count: "1.5" }).valid?
    assert_not event(kind: :water, care_spot: @fountain, actions: [ "refilled" ], details: { stool: "soft" }).valid?, "only litter"
    assert_not event(kind: :fed, pet: @pet, details: { pee: "few" }).valid?
  end

  test "a litter observation may name a cat of the box's household only" do
    scooped = event(kind: :litter, care_spot: @box, actions: [ "scooped" ], pet: @pet)
    assert scooped.save
    assert_equal @household, scooped.household, "the household still comes from the box"
    assert_equal @box, scooped.subject
    assert scooped.observations?

    assert_not event(kind: :litter, care_spot: @box, actions: [ "scooped" ], pet: pets(:two)).valid?, "another household's cat"
    assert_not event(kind: :water, care_spot: @fountain, actions: [ "refilled" ], pet: @pet).valid?, "only litter names a cat"
  end

  test "naming a cat doesn't change the litter repeat question" do
    first = event(kind: :litter, care_spot: @box, actions: [ "scooped" ], pet: @pet, occurred_at: 10.minutes.ago)
    first.save!
    assert_equal first, event(kind: :litter, care_spot: @box, actions: [ "scooped" ]).recent_repeat
    assert_nil event(kind: :fed, pet: @pet).recent_repeat, "a litter record isn't a feeding"
  end

  test "deleting a cat keeps the litter records it was named on, without it" do
    scooped = event(kind: :litter, care_spot: @box, actions: [ "scooped" ], pet: @pet, details: { stool: "soft" })
    scooped.save!
    fed = event(kind: :fed, pet: @pet)
    fed.save!

    @pet.destroy!
    assert_nil scooped.reload.pet_id
    assert_equal({ "stool" => "soft" }, scooped.details)
    assert_not CareEvent.exists?(fed.id)
  end
end
