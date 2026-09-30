require "test_helper"

# Joining a household from an invitation, where people land after signing in,
# the Today page, the caregiver's menu and leaving a household.
class HouseholdJoinsTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    @invitation = @household.invitations.create!(email: "mom@example.com", invited_by: @owner)
    @joined = I18n.t("household_joins.joined", household: "#{@owner.username.capitalize}'s cats")
  end

  def new_user(name, email: "#{name}@example.com")
    User.create!(username: name, email_address: email, email_address_confirmation: email,
                 password: "password123", timezone: "Asia/Taipei", sign_in_count: 3)
  end

  def join_url_for(invitation = @invitation) = join_household_url(token: invitation.token, **L)

  def caregiver?(user) = @household.memberships.exists?(user: user, role: :caregiver)

  test "someone new signs up on the join page with the invited email and lands on Today" do
    get join_url_for
    assert_response :success
    assert_select "input[type=email][disabled][value='mom@example.com']"

    post join_url_for, params: { user: { username: "Mom", password: "password123", password_confirmation: "password123",
                                         timezone: "Asia/Taipei", email_address: "someone-else@example.com" } }

    mom = User.find_by!(email_address: "mom@example.com")
    assert caregiver?(mom)
    assert_redirected_to today_url(**L)
    assert_equal @joined, flash[:notice]
    follow_redirect!
    assert_select "##{ActionView::RecordIdentifier.dom_id(@household)}", text: /Aji|#{pets(:one).petname}/i
    assert_not User.exists?(email_address: "someone-else@example.com"), "the email comes from the invitation"
  end

  test "someone with an account opens the link, signs in and joins" do
    mom = new_user("mom")
    get join_url_for
    post session_url(**L), params: { email_address: mom.email_address, password: "password123" }

    assert caregiver?(mom)
    assert_redirected_to today_url(**L)
    assert_equal @joined, flash[:notice]
    assert_not @invitation.reload.pending?
  end

  test "someone already signed in with the invited email joins with one button" do
    mom = new_user("mom")
    log_in_as(mom)
    get join_url_for
    assert_select "button", text: /Join/

    post join_url_for
    assert caregiver?(mom)
    assert_redirected_to today_url(**L)
  end

  test "an invitation for a different email is refused, on the page and after signing in" do
    stranger = new_user("stranger")
    log_in_as(stranger)
    get join_url_for
    assert_match "mom@example.com", response.body
    assert_select "form[action='#{join_household_path(token: @invitation.token)}']", count: 0

    post join_url_for
    assert_equal I18n.t("activerecord.errors.models.household_invitation.attributes.base.wrong_email"), flash[:alert]
    delete session_url(**L)

    get join_url_for
    post session_url(**L), params: { email_address: stranger.email_address, password: "password123" }
    assert_equal I18n.t("activerecord.errors.models.household_invitation.attributes.base.wrong_email"), flash[:alert]
    assert_redirected_to pets_url(**L), "lands as usual"
    assert_not caregiver?(stranger)
    assert @invitation.reload.pending?
  end

  test "expired, used and made-up links show that the invitation is no longer valid" do
    expired = @household.invitations.create!(email: "dad@example.com", invited_by: @owner)
    expired.update_column(:expires_at, 1.minute.ago)
    @invitation.accept!(new_user("mom"))

    [ join_url_for(expired), join_url_for(@invitation), join_household_url(token: "made-up", **L) ].each do |url|
      get url
      assert_response :not_found
      assert_select "h1", I18n.t("household_joins.expired.title")
      post url, params: { user: { username: "x", password: "password123", password_confirmation: "password123", timezone: "Asia/Taipei" } }
      assert_response :not_found
    end
    assert_not User.exists?(email_address: "dad@example.com")
  end

  test "joining with Google after opening the link" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: "google_oauth2", uid: "g-mom", info: { email: "mom@example.com", name: "Mom" }
    )
    get join_url_for
    post "/auth/google_oauth2?timezone=Asia/Taipei" # the page adds the time zone, as time_zone_controller.js does
    follow_redirect! # to the callback

    mom = User.find_by!(email_address: "mom@example.com")
    assert caregiver?(mom)
    assert_redirected_to today_url(**L)
    assert_equal @joined, flash[:notice]
  ensure
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  test "where people land after signing in" do
    brand_new = User.create!(username: "new", email_address: "new@example.com", email_address_confirmation: "new@example.com",
                             password: "password123", timezone: "Asia/Taipei")
    caregiver = new_user("mom")
    @household.memberships.create!(user: caregiver, role: :caregiver)
    owner_and_helper = users(:two)
    @household.memberships.create!(user: owner_and_helper, role: :viewer)

    { brand_new => new_pet_url(**L), @owner => pets_url(**L), caregiver => today_url(**L), owner_and_helper => today_url(**L) }.each do |user, landing|
      post session_url(**L), params: { email_address: user.email_address, password: "password123" }
      assert_redirected_to landing, user.username
      delete session_url(**L)
    end
  end

  test "Today shows the user's own cats first, then each household they help with" do
    helper = users(:two)
    @household.memberships.create!(user: helper, role: :caregiver)
    log_in_as(helper)
    get today_url(**L)

    sections = css_select("section h2").map { |h2| h2.text.squish }
    assert_equal I18n.t("today.show.my_cats"), sections.first
    assert_match "#{@owner.username.capitalize}'s cats", sections.second
    assert_match I18n.t("today.show.you_are_a.caregiver"), sections.second
    assert_select "a[href='#{pet_trackers_path(pets(:one))}']"
    assert_select "a[href='#{pet_trackers_path(pets(:two))}']"
  end

  test "a caregiver with no cats of their own gets the smaller menu and can add their own cat" do
    mom = new_user("mom")
    @household.memberships.create!(user: mom, role: :caregiver)
    log_in_as(mom)
    get users_url(**L)

    assert_select "a[href='#{today_path}']", minimum: 1
    assert_select "a[href='#{dry_foods_path}']", count: 0
    assert_select "a[href='#{new_pet_path}']", text: I18n.t("users.show.add_my_own_cat")
    assert_select "a[href='#{pet_trackers_path(pets(:one))}']", minimum: 1, message: "Rita's cats in the Trackers menu"
    assert_select "a[href='#{new_pet_tracker_path(pets(:one))}']", count: 0

    post pets_url(**L), params: { pet: { petname: "Kuro", birthday: "2020-01-01", gender: "Male", breed: "Mix", weight: 4 } }
    assert mom.reload.owned_household, "her own household"
    assert_equal @owner, @household.reload.owner, "Rita's household is unaffected"
    assert caregiver?(mom)
    get users_url(**L)
    assert_select "a", text: I18n.t("users.show.add_my_own_cat"), count: 0
    assert_select "a[href='#{dry_foods_path}']", minimum: 1
  end

  test "a caregiver leaves a household and no longer reaches its cats" do
    mom = new_user("mom")
    @household.memberships.create!(user: mom, role: :caregiver)
    log_in_as(mom)

    delete leave_household_url(household_id: @household.id, **L)
    assert_redirected_to users_url(**L)
    assert_not caregiver?(mom)

    get pet_trackers_url(pets(:one), **L)
    assert_equal I18n.t("pets.not_found"), flash[:alert]
  end
end
