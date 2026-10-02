require "test_helper"

# Checkpoint G: the pages that listen for live updates, care records on the
# charts, and the owner's care records CSV.
class LiveUpdatesAndCareChartsTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    @zone = @household.time_zone
    @pet = pets(:one)
    @pet.update!(petname: "aji")
    @umi = @household.pets.create!(petname: "umi", gender: "♀️ Female")
    @mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @mom, role: :caregiver)
    @box = @household.care_spots.create!(kind: :litter_box, name: "Upstairs box")
    @bowl = @household.care_spots.create!(kind: :water_bowl, name: "Kitchen bowl")
  end

  def record(**attributes)
    CareEvent.create!({ actor: @mom, occurred_at: 1.hour.ago }.merge(attributes))
  end

  def stream_for(household) = Turbo::StreamsChannel.signed_stream_name(household)

  test "Today listens to every household it shows, and the notice stays open on others' refreshes" do
    households(:two).memberships.create!(user: @mom, role: :caregiver)
    log_in_as(@mom)
    post care_events_url(**L), params: { pet_id: @pet.id, kind: "fed" }
    follow_redirect!

    assert_select "turbo-cable-stream-source[signed-stream-name='#{stream_for(@household)}']", count: 1
    assert_select "turbo-cable-stream-source[signed-stream-name='#{stream_for(households(:two))}']", count: 1
    assert_select "meta[name='turbo-refresh-method'][content='morph']"
    assert_select "#care_notice[data-controller='keep-on-refresh']"
  end

  test "the viewer page listens to its household only, and keeps its charts on a live update" do
    link = @household.viewer_links.create!(name: "Grandma", created_by: @owner)
    get viewer_page_url(token: link.token, range: "7", **L)

    assert_select "turbo-cable-stream-source", count: 1
    assert_select "turbo-cable-stream-source[signed-stream-name='#{stream_for(@household)}']"
    assert_select "meta[name='turbo-refresh-method'][content='morph']"
    assert_select "meta[name='turbo-refresh-scroll'][content='preserve']"
    assert_select "#viewer_charts_#{@umi.id}_7[data-turbo-permanent]", 0
    assert_select "[data-turbo-permanent][id^='viewer_charts_']", count: 1
  end

  test "Care by day counts the household's litter and water jobs and the cat's own records, per local day" do
    today = Time.current.in_time_zone(@zone).to_date
    record(kind: :litter, care_spot: @box, actions: [ "scooped" ])
    record(kind: :litter, care_spot: @box, actions: [ "full_change" ], pet: @umi, details: { stool: "soft" })
    record(kind: :litter, care_spot: @box, actions: [ "scooped" ], pet: @pet, details: { stool: "soft" })
    record(kind: :water, care_spot: @bowl, actions: [ "refilled" ])
    record(kind: :fed, pet: @pet)
    record(kind: :fed, pet: @umi)
    medication = @pet.medications.create!(name: "Clavamox", dose: "1 tablet", times: [], starts_on: today - 3)
    record(kind: :meds, pet: @pet, medication: medication, dose_status: "given")
    record(kind: :meds, pet: @pet, medication: medication, dose_status: "couldnt_give", reason: "spat_out", occurred_at: 2.days.ago)
    record(kind: :fed, pet: @pet).undo!
    record(kind: :fed, pet: @pet, occurred_at: 6.days.ago)

    chart = CareChart.new(@pet, from: today - 3)
    assert_equal({ today => 1 }, chart.counts["fed"], "the cat's own feedings, not undone, in range")
    assert_equal({ today => 3 }, chart.counts["litter"], "every litter job in the household")
    assert_equal({ today => 1 }, chart.counts["water"])
    assert_equal({ today => 1 }, chart.counts["given"])
    assert_equal({ (2.days.ago.in_time_zone(@zone).to_date) => 1 }, chart.counts["not_given"])
    assert_equal({ today => 1 }, chart.counts["observations"], "only this cat's observations")
    assert_equal [ 2.days.ago.in_time_zone(@zone).to_date, today ], chart.dates
    assert_equal 6, chart.series.size
    assert_equal [ 0, 3 ], chart.series[1][:data].values

    assert_equal({ "fed" => { (6.days.ago.in_time_zone(@zone).to_date) => 1 } }, CareChart.new(@pet, to: today - 4).counts.select { |_, counts| counts.any? })
  end

  test "weights from ⚖️ records join the weight line, averaged with trackers' per day" do
    Time.use_zone(@zone) do
      @pet.trackers.create!(date: 3.days.ago.to_date, feed_time: "08:00", food_type: "wet", brand: "Ciao", description: "Tuna", amount: 40, left_amount: 0, come_back_to_eat: "-", weight: 4.0)
      record(kind: :weight, pet: @pet, value: 4.4, occurred_at: 3.days.ago.change(hour: 20))
      record(kind: :weight, pet: @pet, value: 4.6, occurred_at: 1.day.ago.change(hour: 9))
    end
    calculator = Class.new { include TrackersCalculable }.new

    with_care = calculator.calculate_tracker_data(@pet, { range: "30" }, nil, care: true)
    weights = with_care[:chart_data].last[:data]
    assert_in_delta 4.2, weights[3.days.ago.in_time_zone(@zone).strftime("%y/%m/%d")]
    assert_in_delta 4.6, weights[1.day.ago.in_time_zone(@zone).strftime("%y/%m/%d")]
    assert_equal weights.keys.sort, with_care[:chart_data].first[:data].keys, "a weight-only day keeps its place in date order"

    without = calculator.calculate_tracker_data(@pet, { range: "30" }, nil)
    assert_equal({ 3.days.ago.in_time_zone(@zone).strftime("%y/%m/%d") => 4.0 }, without[:chart_data].last[:data])
    assert_nil without[:care]
  end

  test "the care chart is on the trackers page and the viewer page, not on the public share page" do
    record(kind: :litter, care_spot: @box, actions: [ "scooped" ])
    log_in_as(@mom)
    get pet_trackers_url(@pet, **L)
    assert_select "#care_chart", text: /Care by day/

    link = @household.viewer_links.create!(name: "Grandma", created_by: @owner)
    get viewer_page_url(token: link.token, **L)
    assert_select "#care_chart"

    get shared_pet_trackers_url(share_token: @pet.share_token, **L)
    assert_response :success
    assert_select "#care_chart", count: 0
  end

  test "no care chart without care records" do
    log_in_as(@owner)
    get pet_trackers_url(@pet, **L)
    assert_select "#care_chart", count: 0
  end

  test "the owner downloads every care record as CSV, in the household's time zone" do
    at = @zone.local(2026, 9, 30, 23, 30)
    travel_to at + 1.hour do
      record(kind: :fed, pet: @pet, occurred_at: at, details: { food_type: "kibble", brand: "曙光", amount_g: "40" }, note: "ate half")
      record(kind: :litter, care_spot: @box, actions: %w[scooped full_change], pet: @umi, details: { stool: "diarrhea" }, occurred_at: at + 10.minutes)
      record(kind: :water, care_spot: @bowl, actions: [ "refilled" ], occurred_at: at + 20.minutes).undo!
      record(kind: :weight, pet: @pet, value: 4.25, occurred_at: at + 30.minutes)
    end

    log_in_as(@owner)
    get household_care_records_url(format: :csv, **L)
    assert_response :success
    assert_equal "text/csv", response.media_type
    assert_match(/care-records-\d{4}-\d{2}-\d{2}\.csv/, response.headers["Content-Disposition"])

    rows = CSV.parse(response.body, col_sep: ";")
    assert_equal [ "Date", "Time", "Type", "Cat", "Litter box or water spot", "Jobs", "Details", "Weight (kg)", "Note", "Recorded by", "Changed" ], rows.first
    assert_equal 4, rows.size, "the undone tap is left out"
    assert_equal [ "2026-09-30", "23:30", "Fed", "Aji", nil, nil, "Kibble · 曙光 · 40 g", nil, "ate half", "Mom", nil ], rows[1]
    assert_equal [ "2026-09-30", "23:40", "Litter", "Umi", "Upstairs box", "scooped, full change", "stool diarrhea", nil, nil, "Mom", nil ], rows[2]
    assert_equal [ "2026-10-01", "00:00", "Weight", "Aji", nil, nil, nil, "4.25", nil, "Mom", nil ], rows[3]
  end

  test "caregivers can't download the care records" do
    log_in_as(@mom)
    get household_care_records_url(format: :csv, **L)
    assert_redirected_to new_pet_url(**L)
  end
end
