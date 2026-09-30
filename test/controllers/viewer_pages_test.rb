require "test_helper"

class ViewerPagesTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    @link = @household.viewer_links.create!(name: "Grandma", created_by: @owner)
    @following = I18n.t("viewer_pages.following", household: "#{@owner.username.capitalize}'s cats")
  end

  def page_url(link = @link, **params) = viewer_page_url(token: link.token, **L, **params)

  def new_user(name)
    User.create!(username: name, email_address: "#{name}@example.com", email_address_confirmation: "#{name}@example.com",
                 password: "password123", timezone: "Asia/Taipei", sign_in_count: 3)
  end

  test "the link opens its household's charts, with no sign-in, no app menu and no indexing" do
    get page_url

    assert_response :success
    assert_select "h1", text: /#{@owner.username.capitalize}'s cats · shared with Grandma/
    assert_select "meta[name=robots][content='noindex, nofollow']"
    assert_equal "noindex, nofollow", response.headers["X-Robots-Tag"]
    assert_equal "no-referrer", response.headers["Referrer-Policy"]
    assert_select "select[name=pet_id] option", count: @household.pets.count
    assert_select "select[name=pet_id] option[value='#{pets(:two).id}']", count: 0
    assert_select "a[href='#{new_pet_path}']", count: 0, message: "no app menu"
    assert_not_nil @link.reload.last_used_at
  end

  test "another household's cat can't be picked" do
    get page_url(pet_id: pets(:two).id)

    assert_select "select[name=pet_id] option[selected][value='#{pets(:one).id}']"
  end

  test "turned-off, expired and made-up links say the link is no longer active" do
    get page_url
    assert_response :success
    @link.revoke!

    expired = @household.viewer_links.create!(name: "Ken", created_by: @owner, expires_at: 1.day.from_now)
    expired.update_column(:expires_at, 1.minute.ago)

    [ page_url, page_url(expired), viewer_page_url(token: "made-up", **L) ].each do |url|
      get url
      assert_response :not_found
      assert_select "h1", text: /#{I18n.t("viewer_pages.inactive.title")}/
      assert_equal "noindex, nofollow", response.headers["X-Robots-Tag"]
    end
  end

  test "signing in from the page adds the household to the account as a viewer" do
    gran = new_user("gran")
    get page_url
    post page_url
    assert_redirected_to new_session_url(**L)

    post session_url(**L), params: { email_address: gran.email_address, password: "password123" }
    assert_equal "viewer", @household.memberships.find_by(user: gran)&.role
    assert_redirected_to today_url(**L)
    assert_equal @following, flash[:notice]
  end

  test "signing up from the page adds the household too" do
    post page_url, params: { then: "sign_up" }
    assert_redirected_to new_registrations_url(**L)

    post registrations_url(**L), params: { user: { username: "Gran", email_address: "gran@example.com", email_address_confirmation: "gran@example.com",
                                                   password: "password123", password_confirmation: "password123", timezone: "Asia/Taipei" } }
    gran = User.find_by!(email_address: "gran@example.com")
    assert @household.memberships.viewer.exists?(user: gran)
    assert_redirected_to today_url(**L)
  end

  test "only opening the page doesn't add anything to an account signed in later" do
    gran = new_user("gran")
    get page_url
    post session_url(**L), params: { email_address: gran.email_address, password: "password123" }

    assert_not @household.memberships.exists?(user: gran)
  end

  test "someone signed in adds it with one button; owners and caregivers keep what they have" do
    gran = new_user("gran")
    log_in_as(gran)
    get page_url
    assert_select "#follow button", text: I18n.t("viewer_pages.show.add_to_account")
    post page_url
    assert @household.memberships.viewer.exists?(user: gran)
    get page_url
    assert_select "#follow", text: /#{I18n.t("viewer_pages.show.already_following")}/

    mom = new_user("mom")
    @household.memberships.create!(user: mom, role: :caregiver)
    log_in_as(mom)
    post page_url
    assert @household.memberships.caregiver.exists?(user: mom)

    log_in_as(@owner)
    assert_no_difference -> { HouseholdMembership.count } do
      post page_url
    end
  end

  test "the page shows the household's status and today's timeline, without buttons or notes" do
    box = @household.care_spots.create!(kind: :litter_box, name: "Upstairs box")
    mom = new_user("mom")
    @household.memberships.create!(user: mom, role: :caregiver)
    CareEvent.create!(kind: :litter, care_spot: box, actions: [ "scooped" ], actor: mom, occurred_at: 5.minutes.ago)
    CareEvent.create!(kind: :fed, pet: pets(:one), actor: mom, occurred_at: 3.minutes.ago, note: "private note")

    get page_url
    assert_select "#today_status", text: /Upstairs box: scooped · Mom/
    assert_select "#today_status", text: /Fed \d\d:\d\d by Mom/
    assert_select "#today_status button", count: 0
    assert_select "#today_status a", count: 0
    assert_no_match "private note", response.body
    assert_no_match "mom@example.com", response.body
  end
end
