require "test_helper"

# Sign-up asks people to confirm their email address (security scan F24, and
# the root of F10, F19 and F25). Until then the account can't share anything or
# be found by its address.
class EmailConfirmationTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper
  L = { locale: I18n.default_locale }.freeze

  def sign_up(name)
    perform_enqueued_jobs do
      post registrations_path(**L), params: { user: { username: name, email_address: "#{name}@example.com", email_address_confirmation: "#{name}@example.com",
                                                      password: "password123", password_confirmation: "password123", timezone: "UTC" } }
    end
    User.find_by!(email_address: "#{name}@example.com")
  end

  def confirmation_link
    mail = ActionMailer::Base.deliveries.reverse.find { |m| m.subject == I18n.t("user_mailer.email_confirmation.subject") }
    assert mail, "a confirmation email was sent"
    mail.text_part.body.decoded[%r{https?://\S+/confirm_email/\S+}]
  end

  test "a password sign-up is unconfirmed, gets a link with no text it typed, and the link confirms it" do
    user = sign_up("newbie")
    assert_not user.email_confirmed?
    link = confirmation_link
    assert_no_match "newbie", ActionMailer::Base.deliveries.last.text_part.body.decoded.sub(link, "").sub("newbie@example.com", "")

    get link
    assert user.reload.email_confirmed?
  end

  test "an unconfirmed account can't invite, make viewer links or turn on a share link" do
    user = sign_up("newbie")
    post pets_path(**L), params: { pet: { petname: "Mochi" } }
    pet = user.owned_pets.sole

    assert_no_difference("HouseholdInvitation.count") { post household_invitations_path(**L), params: { email: "mom@example.com" } }
    assert_no_difference("ViewerLink.count") { post household_viewer_links_path(**L), params: { name: "Gran" } }
    post pet_share_path(pet, **L), params: { expires_in: Pet::SHARE_DURATIONS.keys.first }
    assert_not pet.reload.sharing?
    assert_match I18n.t("email_confirmations.required", email: user.email_address), flash[:alert]
  end

  test "a vet visit can't be shared with an unconfirmed account" do
    sign_up("partner")
    delete session_path(**L)
    log_in_as users(:one)
    post pet_vet_visits_path(pets(:one), **L), params: { vet_visit: { question: "Q?", visit_date: Date.current, member_emails: [ "partner@example.com" ] } }
    assert_empty VetVisitMember.joins(:user).where(users: { email_address: "partner@example.com" })
  end

  test "changing the address makes the account unconfirmed and sends a link to the new address" do
    log_in_as users(:one)
    perform_enqueued_jobs do
      patch users_path(**L), params: { user: { email_address: "new-one@example.com", current_password: "password123" } }
    end
    assert_not users(:one).reload.email_confirmed?
    assert_equal [ "new-one@example.com" ], ActionMailer::Base.deliveries.last.to
  end

  test "a password reset confirms the address; on a never-confirmed account it removes the household's access" do
    owner = sign_up("pre")
    post pets_path(**L), params: { pet: { petname: "Decoy" } }
    household = owner.reload.owned_household
    link = household.viewer_links.create!(name: "Spy", created_by: owner)
    member = User.create!(username: "spy2", email_address: "spy2@example.com", email_address_confirmation: "spy2@example.com",
                          password: "password123", timezone: "UTC", email_confirmed_at: Time.current)
    household.memberships.create!(user: member, role: :caregiver)

    patch password_path(owner.password_reset_token, **L), params: { password: "brand-new-pass", password_confirmation: "brand-new-pass" }
    assert owner.reload.email_confirmed?
    assert_not link.reload.active?
    assert_empty household.memberships.reload
    assert_match I18n.t("passwords.update.household_revoked"), flash[:notice]
  end

  test "a wrong or old link confirms nothing" do
    user = sign_up("newbie")
    token = user.generate_token_for(:email_confirmation)
    user.update!(email_address: "other@example.com")
    get email_confirmation_path(token: token, **L)
    assert_not user.reload.email_confirmed?
    assert_equal I18n.t("email_confirmations.show.invalid"), flash[:alert]
  end
end
