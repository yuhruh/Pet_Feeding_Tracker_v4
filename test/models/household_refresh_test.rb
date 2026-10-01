require "test_helper"
require "turbo/broadcastable/test_helper"

# Live updates (checkpoint G): each change in a household sends that household's
# open pages a refresh, which carries no data; other households hear nothing.
class HouseholdRefreshTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper
  include ActionCable::TestHelper
  include Turbo::Broadcastable::TestHelper
  setup do
    @owner = users(:one)
    @household = households(:one)
    @pet = pets(:one)
    @box = @household.care_spots.create!(kind: :litter_box)
  end

  def refreshes(household = @household, count: 1, &block)
    broadcasts = capture_turbo_stream_broadcasts(household) { perform_enqueued_jobs(&block) }
    assert_equal count, broadcasts.size
    broadcasts.each { |stream| assert_equal "refresh", stream["action"] }
    broadcasts
  end

  test "a care record refreshes its household's pages when saved, changed and undone" do
    event = nil
    stream = refreshes { event = CareEvent.create!(kind: :fed, pet: @pet, actor: @owner, occurred_at: Time.current, note: "secret note") }.sole
    assert_no_match "secret", stream.to_html, "a refresh carries no data"
    assert_no_match "MyString", stream.to_html

    refreshes { event.update!(note: "changed") }
    refreshes { event.undo! }
  end

  test "trackers, medications and litter boxes or water spots refresh their household too" do
    refreshes { @pet.trackers.create!(date: Date.current, feed_time: "08:00", food_type: "Wet", brand: "Ciao", description: "Tuna", amount: 40) }
    refreshes { @pet.medications.create!(name: "Clavamox", dose: "1 tablet", times: [ "08:00" ], starts_on: Date.current) }
    refreshes { @box.update!(name: "Upstairs box") }
  end

  test "another household hears nothing" do
    assert_no_turbo_stream_broadcasts(households(:two)) do
      perform_enqueued_jobs { CareEvent.create!(kind: :litter, care_spot: @box, actions: [ "scooped" ], actor: @owner, occurred_at: Time.current) }
    end
  end
end
