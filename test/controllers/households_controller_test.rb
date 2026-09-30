require "test_helper"

class HouseholdsControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    log_in_as(@owner)
  end

  def new_user(name)
    User.create!(username: name, email_address: "#{name}@example.com", email_address_confirmation: "#{name}@example.com",
                 password: "password123", timezone: "Asia/Taipei")
  end

  test "the owner sees their household's members, invitations and viewer links" do
    mom = new_user("mom")
    @household.memberships.create!(user: mom, role: :caregiver)
    @household.invitations.create!(email: "dad@example.com", invited_by: @owner)
    @household.viewer_links.create!(name: "Grandma", created_by: @owner)

    get household_url(**L)

    assert_response :success
    assert_select "h1", text: "#{@owner.username.capitalize}'s cats"
    assert_match "mom@example.com", response.body
    assert_match "dad@example.com", response.body
    assert_match "Grandma", response.body
  end

  test "the account page and menu link to the household page for owners only" do
    get users_url(**L)
    assert_select "a[href='#{household_path}']", minimum: 2

    log_in_as(User.create!(username: "newbie", email_address: "newbie@example.com", email_address_confirmation: "newbie@example.com",
                           password: "password123", timezone: "Asia/Taipei"))
    get users_url(**L)
    assert_select "a[href='#{household_path}']", count: 0
  end

  test "someone without cats is sent to add one first" do
    log_in_as(new_user("newbie"))
    get household_url(**L)

    assert_redirected_to new_pet_url(**L)
    assert_equal I18n.t("households.needs_a_cat"), flash[:alert]
  end

  test "inviting a caregiver emails a join link, and a new invitation replaces an earlier one" do
    assert_enqueued_emails(1) { post household_invitations_url(**L), params: { email: "Mom@Example.com" } }
    assert_equal I18n.t("household_invitations.create.notice", email: "mom@example.com"), flash[:notice]
    first = @household.invitations.sole

    perform_enqueued_jobs { post household_invitations_url(**L), params: { email: "mom@example.com" } }
    assert_not first.reload.pending?, "the earlier link stops working"
    mail = ActionMailer::Base.deliveries.last
    assert_equal [ "mom@example.com" ], mail.to
    assert_match "invited you to help look after", mail.subject
    token = mail.text_part.body.decoded[%r{/join/([\w-]+)}, 1]
    assert_equal @household.invitations.pending.sole, HouseholdInvitation.find_by_token(token)
  end

  test "an invitation to yourself or a bad address is refused with a plain message" do
    post household_invitations_url(**L), params: { email: @owner.email_address }
    assert_equal "That's your own email address.", flash[:alert]

    post household_invitations_url(**L), params: { email: "not-an-email" }
    assert_equal "That doesn't look like an email address.", flash[:alert]
    assert_empty @household.invitations
  end

  test "the owner cancels an invitation" do
    invitation = @household.invitations.create!(email: "mom@example.com", invited_by: @owner)

    delete household_invitation_url(invitation, **L)

    assert_not invitation.reload.pending?
  end

  test "a new viewer link is shown once, and can be turned off" do
    post household_viewer_links_url(**L), params: { name: "Grandma", expires_in: "30_days" }
    link = @household.viewer_links.sole
    assert_in_delta 30.days.from_now, link.expires_at, 5

    follow_redirect!
    url = css_select("#new_viewer_link").first["value"]
    token = url[%r{/view/([\w-]+)}, 1]
    assert_equal link, ViewerLink.find_active(token)

    get household_url(**L)
    assert_select "#new_viewer_link", count: 0, message: "only shown right after it's made"

    delete household_viewer_link_url(link, **L)
    assert_not link.reload.active?
    assert_nil ViewerLink.find_active(token)
  end

  test "the owner removes a member" do
    membership = @household.memberships.create!(user: new_user("mom"), role: :caregiver)

    delete household_member_url(membership, **L)

    assert_not HouseholdMembership.exists?(membership.id)
  end

  test "one owner can't touch another household's invitations, links or members" do
    other = households(:two)
    invitation = other.invitations.create!(email: "x@example.com", invited_by: users(:two))
    link = other.viewer_links.create!(name: "X", created_by: users(:two))
    membership = other.memberships.create!(user: new_user("mom"), role: :caregiver)

    delete household_invitation_url(invitation, **L)
    assert_response :not_found
    delete household_viewer_link_url(link, **L)
    assert_response :not_found
    delete household_member_url(membership, **L)
    assert_response :not_found
    assert invitation.reload.pending? && link.reload.active? && HouseholdMembership.exists?(membership.id)
  end
end
