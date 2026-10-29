require "test_helper"

class TrackersControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as(users(:one))
    @pet = pets(:one)
    @tracker = @pet.trackers.create(date: "2026-01-01", feed_time: "10:02", hungry: "💖 Yes, eat right away",
    come_back_to_eat: "21:29, 00:24, 4:46", food_type: "Wet", brand: "Ciao", description: "imc-222 果凍杯 鮪魚+雞肉+干貝 x3",
    amount: 105, left_amount: 40, total_ate_amount: 65)
    # @user = User.create(email_address: "example@email.com", password: "password", password_confirmation: "password", username: "John Doe", timezone: "Asia/Taipei")
    # post session_url, params: { email_address: @user.email_address, password: "password" }
  end

  test "should get index" do
    get pet_trackers_url(@pet)
    assert_response :success
  end

  test "searching keeps the chosen per page, and choosing per page keeps the search" do
    get pet_trackers_url(@pet, per_page: 50)
    get pet_trackers_url(@pet, brand: "Ciao", range: "30")
    assert_select "form:has(input[name=brand]) input[type=hidden][name=per_page][value='50']"
    assert_select "form:has(input[name=brand]) input[type=hidden][name=range][value='30']"
    assert_select "select[name=per_page] option[selected][value='50']"
    assert_select "form:has(select[name=per_page]) input[type=hidden][name=brand][value='Ciao']"
    assert_select "form:has(select[name=range]) input[type=hidden][name=brand][value='Ciao']"
  end

  test "export offers the filtered records beside all of them only while a filter is on" do
    @pet.trackers.create!(date: "2026-01-02", feed_time: "09:00", food_type: "Kibble", brand: "Orijen", description: "Six fish", amount: 30, total_ate_amount: 30)

    get pet_trackers_url(@pet, range: "all", per_page: 50)
    assert_select "a[href=?]", pet_trackers_path(@pet, format: :csv), count: 1
    assert_select "a[href*='.csv?']", count: 0

    get pet_trackers_url(@pet, brand: "Ciao", per_page: 50)
    assert_select "a[href=?]", pet_trackers_path(@pet, format: :csv), count: 1
    assert_select "a[href=?]", pet_trackers_path(@pet, format: :csv, brand: "Ciao"), text: /\(1\)/

    get pet_trackers_url(@pet, format: :csv, brand: "Ciao")
    assert_match(/ciao/i, response.body)
    assert_no_match(/orijen/i, response.body)
    assert_match(/-trackers-filtered-/, response.headers["Content-Disposition"])

    get pet_trackers_url(@pet, format: :csv)
    assert_match(/orijen/i, response.body)
    assert_no_match(/filtered/, response.headers["Content-Disposition"])
  end

  test "should get new" do
    get new_pet_tracker_url(@pet)
    assert_response :success
  end

  test "should create tracker" do
    assert_difference("Tracker.count") do
      post pet_trackers_url(@pet), params: { tracker: { amount: @tracker.amount, brand: @tracker.brand, date: @tracker.date, description: @tracker.description, dry_food_id: @tracker.dry_food_id, favorite_score: @tracker.favorite_score, feed_time: @tracker.feed_time, food_type: @tracker.food_type, frequency: @tracker.frequency, hungry: @tracker.hungry, left_amount: @tracker.left_amount, love: @tracker.love, note: @tracker.note, pet_id: @tracker.pet_id, result: @tracker.result, total_ate_amount: @tracker.total_ate_amount, weight: @tracker.weight } }
    end

    per_page = 10 # Default per_page
    total_trackers = @pet.trackers.count
    expected_page = (total_trackers.to_f / per_page).ceil
    assert_redirected_to pet_trackers_url(@pet, page: expected_page > 1 ? expected_page : nil, locale: I18n.default_locale)
  end

  # test "should show tracker" do
  #   get pet_tracker_url(@pet, @tracker)
  #   assert_response :success
  # end

  test "should get edit" do
    get edit_pet_tracker_url(@pet, @tracker)
    assert_response :success
  end

  test "should update tracker" do
    patch pet_tracker_url(@pet, @tracker), params: { tracker: { come_back_to_eat: @tracker.come_back_to_eat, date: @tracker.date, description: @tracker.description, dry_food_id: @tracker.dry_food_id, favorite_score: @tracker.favorite_score, feed_time: @tracker.feed_time, food_type: @tracker.food_type, frequency: @tracker.frequency, hungry: @tracker.hungry, left_amount: @tracker.left_amount, love: @tracker.love, note: @tracker.note, pet_id: @tracker.pet_id, result: @tracker.result, total_ate_amount: @tracker.total_ate_amount, weight: @tracker.weight, page: 1 } }
    assert_redirected_to pet_trackers_url(@pet, page: 1, locale: I18n.default_locale)
  end

  test "should destroy tracker" do
    assert_difference("Tracker.count", -1) do
      delete pet_tracker_url(@pet, @tracker, page: 1)
    end

    assert_redirected_to pet_trackers_url(@pet, page: "1", locale: I18n.default_locale)
  end

  test "should import trackers from csv" do
    file = fixture_file_upload(Rails.root.join("test/fixtures/files/trackers.csv"), "text/csv")
    assert_difference("Tracker.count", 1) do
      post import_pet_trackers_url(@pet), params: { file: file }
    end
    assert_redirected_to pet_trackers_path(@pet)
    assert_equal I18n.t("trackers.import.notice", petname: @pet.petname.capitalize), flash[:notice]

    tracker = Tracker.last
    assert_equal Time.zone.parse("10:00").utc.strftime("%H:%M"), tracker.feed_time.utc.strftime("%H:%M")
  end

  # users(:one) is in Asia/Taipei: 00:20 is stored as 16:20 UTC and 09:25 as 01:25 UTC.
  test "index lists a day's feedings by local feed time, latest first" do
    create_finished_feedings_at("00:20", "09:25")
    get pet_trackers_url(@pet)
    assert_local_order "09:25", "00:20"
  end

  test "shared page lists a day's feedings by local feed time, latest first" do
    create_finished_feedings_at("00:20", "09:25")
    get shared_pet_trackers_url(share_token: @pet.share_token)
    assert_local_order "09:25", "00:20"
  end

  private
    def create_finished_feedings_at(*times)
      Time.use_zone(users(:one).timezone) do
        times.each do |time|
          @pet.trackers.create!(date: "2026-05-01", feed_time: time, food_type: "wet", brand: "Ciao", description: "Tuna", amount: 40, left_amount: 5, come_back_to_eat: "-")
        end
      end
    end

    def assert_local_order(earlier, later)
      assert_response :success
      assert_includes response.body, "#{earlier}</td>"
      assert_includes response.body, "#{later}</td>"
      assert_operator response.body.index("#{earlier}</td>"), :<, response.body.index("#{later}</td>"), "#{earlier} should be listed before #{later}"
    end
end
