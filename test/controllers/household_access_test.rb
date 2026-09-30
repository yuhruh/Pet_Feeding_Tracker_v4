require "test_helper"

# Who can do what with a household's cats: the owner everything; a caregiver reads
# the trackers and charts; a viewer sees the charts; anyone else finds nothing.
class HouseholdAccessTest < ActionDispatch::IntegrationTest
  setup do
    @owner = users(:one)
    @pet = pets(:one)
    @household = households(:one)
    @caregiver = member("caregiver")
    @viewer = member("viewer")
    @outsider = users(:two) # owns a different household
    @tracker = @pet.trackers.create!(date: Date.current, feed_time: "08:00", food_type: "Wet", brand: "Ciao", description: "Tuna",
                                     amount: 40, hungry: "💖 Yes, eat right away", love: "💕")
  end

  def member(role)
    user = User.create!(username: role, email_address: "#{role}@example.com", email_address_confirmation: "#{role}@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: user, role: role)
    user
  end

  # :allowed, :denied (only the owner may) or :not_found, from this response. A
  # refusal redirects with its message (or is a 403/404); a page that merely shows
  # the message left by the previous request was allowed.
  def outcome
    return :not_found if response.status == 404
    return :denied if response.status == 403
    return :allowed unless response.redirect?

    alert = flash[:alert].to_s
    return :not_found if alert == I18n.t("pets.not_found")
    return :denied if alert == I18n.t("households.owner_only", petname: @pet.petname.capitalize) ||
                      alert.in?([ I18n.t("vet_visits.unauthorized"), I18n.t("vet_visits.unauthorized_owner") ])

    :allowed
  end

  L = { locale: I18n.default_locale }.freeze

  # [description, method, path, params, expected for owner / caregiver / viewer / outsider]
  def routes
    pet, tracker = @pet, @tracker
    csv = Rack::Test::UploadedFile.new(Rails.root.join("test/fixtures/files/trackers.csv"), "text/csv")
    tracker_params = { tracker: { date: Date.current, food_type: "Wet", brand: "Ciao", description: "Tuna", amount: 40 } }
    [
      [ "pet profile",            :get,    pet_url(pet, **L), {},                               %i[allowed denied denied not_found] ],
      [ "edit pet",               :get,    edit_pet_url(pet, **L), {},                          %i[allowed denied denied not_found] ],
      [ "update pet",             :patch,  pet_url(pet, **L), { pet: { petname: "Renamed" } },  %i[allowed denied denied not_found] ],
      [ "trackers and charts",    :get,    pet_trackers_url(pet, **L), {},                      %i[allowed allowed allowed not_found] ],
      [ "export trackers (CSV)",  :get,    pet_trackers_url(pet, format: :csv, **L), {},        %i[allowed denied denied not_found] ],
      [ "favorite list",          :get,    favorite_food_pet_trackers_url(pet, **L), {},        %i[allowed allowed denied not_found] ],
      [ "new tracker",            :get,    new_pet_tracker_url(pet, **L), {},                   %i[allowed denied denied not_found] ],
      [ "add tracker",            :post,   pet_trackers_url(pet, **L), tracker_params,          %i[allowed denied denied not_found] ],
      [ "edit tracker",           :get,    edit_pet_tracker_url(pet, tracker, **L), {},         %i[allowed denied denied not_found] ],
      [ "update tracker",         :patch,  pet_tracker_url(pet, tracker, **L), { tracker: { note: "x" } }, %i[allowed denied denied not_found] ],
      [ "import trackers",        :post,   import_pet_trackers_url(pet, **L), { file: csv },    %i[allowed denied denied not_found] ],
      [ "bulk delete trackers",   :delete, bulk_delete_pet_trackers_url(pet, **L), { tracker_ids: [ tracker.id ] }, %i[allowed denied denied not_found] ],
      [ "delete tracker",         :delete, pet_tracker_url(pet, tracker, page: 1, **L), {},     %i[allowed denied denied not_found] ],
      [ "health checks",          :get,    pet_health_checks_url(pet, **L), {},                 %i[allowed denied denied not_found] ],
      [ "new health check",       :get,    new_pet_health_check_url(pet, **L), {},              %i[allowed denied denied not_found] ],
      [ "turn on share link",     :post,   pet_share_url(pet, **L), { expires_in: "7_days" },   %i[allowed denied denied not_found] ],
      [ "turn off share link",    :delete, pet_share_url(pet, **L), {},                         %i[allowed denied denied not_found] ],
      [ "kibble prices",          :get,    pet_kibble_prices_url(pet, **L), {},                 %i[allowed denied denied not_found] ],
      [ "refresh kibble prices",  :post,   pet_kibble_prices_url(pet, **L), {},                 %i[allowed denied denied not_found] ],
      # Vet visits keep their own rule (owner, or a member of that visit), and its own messages.
      [ "vet visits",             :get,    pet_vet_visits_url(pet, **L), {},                    %i[allowed denied denied denied] ],
      [ "new vet visit",          :get,    new_pet_vet_visit_url(pet, **L), {},                 %i[allowed denied denied denied] ],
      [ "delete pet",             :delete, pet_url(pet, **L), {},                               %i[allowed denied denied not_found] ]
    ]
  end

  test "each role on each page" do
    people = { owner: @owner, caregiver: @caregiver, viewer: @viewer, outsider: @outsider }
    failures = []

    people.each_with_index do |(role, user), column|
      log_in_as(user)
      routes.each do |name, verb, path, params, expected|
        next if role == :owner && verb != :get # the owner's changes are covered by each page's own tests

        send(verb, path, params: params)
        got = outcome
        failures << "#{role} · #{name}: expected #{expected[column]}, got #{got} (#{response.status})" unless got == expected[column]
      end
      delete session_url(**L)
    end

    assert_empty failures, failures.join("\n")
  end

  test "refused changes leave the data alone" do
    [ @caregiver, @viewer, @outsider ].each do |user|
      log_in_as(user)
      assert_no_difference -> { Tracker.count } do
        post pet_trackers_url(@pet, **L), params: { tracker: { date: Date.current, food_type: "Wet", brand: "Ciao", description: "Tuna", amount: 40 } }
        delete pet_tracker_url(@pet, @tracker, page: 1, **L)
        delete bulk_delete_pet_trackers_url(@pet, **L), params: { tracker_ids: [ @tracker.id ] }
      end
      assert_no_changes -> { [ @pet.reload.petname, @pet.share_token ] } do
        patch pet_url(@pet, **L), params: { pet: { petname: "Renamed" } }
        delete pet_share_url(@pet, **L)
      end
      assert Pet.exists?(@pet.id)
      delete session_url(**L)
    end
  end

  test "a caregiver reads the tracker list without the owner's controls" do
    log_in_as(@caregiver)
    get pet_trackers_url(@pet, **L)

    assert_response :success
    assert_select "#trackers"
    assert_match(/ciao/i, response.body)
    assert_select "a[href='#{new_pet_tracker_path(@pet)}']", count: 0
    assert_select "a[href='#{edit_pet_tracker_path(@pet, @tracker)}']", count: 0
    assert_select "a[href='#{pet_trackers_path(@pet, format: :csv)}']", count: 0
    assert_select "form[action='#{import_pet_trackers_path(@pet)}']", count: 0
    assert_select "#share_settings", count: 0
    assert_select "input[name='tracker_ids[]']", count: 0
  end

  test "a viewer sees the charts only" do
    log_in_as(@viewer)
    get pet_trackers_url(@pet, **L)

    assert_response :success
    assert_select "#trackers", count: 0
    assert_no_match(/ciao/i, response.body)
    assert_select "form[action='#{pet_trackers_path(@pet)}'] select[name=range]", minimum: 1, message: "the chart range is still there"
  end

  test "refused JSON requests get 403 and not-found ones 404" do
    log_in_as(@caregiver)
    post pet_trackers_url(@pet, format: :json, **L), params: { tracker: { amount: 1 } }
    assert_response :forbidden
    assert_equal I18n.t("households.owner_only", petname: @pet.petname.capitalize), response.parsed_body["error"]

    log_in_as(@outsider)
    delete pet_tracker_url(@pet, @tracker, format: :json, **L)
    assert_response :not_found
  end

  test "food bags stay with their household" do
    log_in_as(@caregiver)
    get dry_food_url(dry_foods(:one), **L)
    assert_equal I18n.t("dry_foods.not_found"), flash[:alert], "a caregiver's own food bag list is their own household's"

    @tracker.update!(dry_food: nil)
    assert_not @pets_two_tracker = pets(:two).trackers.build(date: Date.current, food_type: "Kibble", brand: "x", description: "xx",
                                                             amount: 1, dry_food: dry_foods(:one)).valid?,
               "a tracker can't use another household's bag"
  end
end
