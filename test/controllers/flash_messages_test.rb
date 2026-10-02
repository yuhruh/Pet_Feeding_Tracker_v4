require "test_helper"

# Only real messages (notice, alert) appear as message boxes. Other flash keys
# carry data to the next page (the saved care record's id, the "Record it
# again?" question, a new viewer link) and used to show up as red boxes, e.g.
# a lone "4" after a tap.
class FlashMessagesTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    @pet = pets(:one)
    @pet.update!(petname: "aji")
    log_in_as(@owner)
  end

  def message_boxes = css_select("[role=alert].alert-message").map { |box| box.text.squish.delete_suffix(" ×") }

  test "a tap shows the saved notice, not the record's id" do
    post care_events_url(**L), params: { pet_id: @pet.id, kind: "fed" }
    follow_redirect!
    assert_select "#care_notice", text: /Aji: fed/
    assert_empty message_boxes
    assert_no_match(/>\s*#{CareEvent.last.id}\s*</, css_select("[role=alert]").to_s)
  end

  test "the Record it again? question isn't shown as a message box too" do
    post care_events_url(**L), params: { pet_id: @pet.id, kind: "fed" }
    post care_events_url(**L), params: { pet_id: @pet.id, kind: "fed" }
    follow_redirect!
    assert_select "button", text: "Record again"
    assert_empty message_boxes
  end

  test "deleting shows only its notice" do
    post care_events_url(**L), params: { pet_id: @pet.id, kind: "fed" }
    event = CareEvent.last
    delete care_event_url(event, **L)
    follow_redirect!
    assert_equal 1, message_boxes.size
    assert_match(/\ADeleted\. Aji: fed at \d\d:\d\d\z/, message_boxes.sole)
  end

  test "a new viewer link shows its notice in green and the link in its own box, not as a red message" do
    post household_viewer_links_url(**L), params: { name: "Grandma", expires_in: "never" }
    follow_redirect!
    assert_equal [ I18n.t("viewer_links.create.notice", name: "Grandma") ], message_boxes
    assert_select "[role=alert].bg-red-100", count: 0
  end
end
