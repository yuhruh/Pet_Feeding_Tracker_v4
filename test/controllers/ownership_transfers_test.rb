require "test_helper"

class OwnershipTransfersTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    @mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @mom, role: :caregiver)
  end

  def offer_to(user)
    log_in_as(@owner)
    post household_ownership_transfers_url(**L), params: { to_user_id: user.id }
  end

  test "the owner offers the household to a member, who gets an email and accepts in the app" do
    perform_enqueued_jobs { offer_to(@mom) }
    transfer = @household.ownership_transfers.pending.sole
    assert_equal I18n.t("ownership_transfers.create.notice", name: "mom"), flash[:notice]
    mail = ActionMailer::Base.deliveries.last
    assert_equal [ "mom@example.com" ], mail.to
    assert_match ownership_transfer_offer_path(transfer), mail.text_part.body.decoded

    get household_url(**L)
    assert_select "#transfer", text: /Waiting for mom/

    log_in_as(@mom)
    get today_url(**L)
    assert_select "a[href='#{ownership_transfer_offer_path(transfer)}']"
    get ownership_transfer_offer_url(transfer, **L)
    assert_response :success

    patch ownership_transfer_offer_url(transfer, **L)
    assert_redirected_to household_url(**L)
    assert_equal @mom, @household.reload.owner
    assert @household.memberships.caregiver.exists?(user: @owner), "the former owner stays as a caregiver"

    delete session_url(**L)
    post session_url(**L), params: { email_address: @owner.email_address, password: "password123" }
    assert_redirected_to today_url(**L), "the former owner now helps with the cats"
  end

  test "a new offer replaces the earlier one, and the owner can withdraw it" do
    gran = User.create!(username: "gran", email_address: "gran@example.com", email_address_confirmation: "gran@example.com",
                        password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: gran, role: :viewer)
    offer_to(@mom)
    first = @household.ownership_transfers.sole
    post household_ownership_transfers_url(**L), params: { to_user_id: gran.id }
    assert_not first.reload.pending?

    second = @household.ownership_transfers.pending.sole
    delete household_ownership_transfer_url(second, **L)
    assert_not second.reload.pending?

    log_in_as(gran)
    get ownership_transfer_offer_url(second, **L)
    assert_select "form[action='#{ownership_transfer_offer_path(second)}']", count: 0
    patch ownership_transfer_offer_url(second, **L)
    assert_equal I18n.t("activerecord.errors.models.ownership_transfer.attributes.base.not_pending"), flash[:alert]
    assert_equal @owner, @household.reload.owner
  end

  test "only a member can be offered the household" do
    offer_to(users(:two))

    assert_equal I18n.t("activerecord.errors.models.ownership_transfer.attributes.to_user.not_a_member"), flash[:alert]
    assert_empty @household.ownership_transfers
  end

  test "no one else can see or accept an offer" do
    offer_to(@mom)
    transfer = @household.ownership_transfers.sole

    [ users(:two), @owner ].each do |user|
      log_in_as(user)
      get ownership_transfer_offer_url(transfer, **L)
      assert_redirected_to today_url(**L)
      patch ownership_transfer_offer_url(transfer, **L)
      assert_redirected_to today_url(**L)
    end
    assert_equal @owner, @household.reload.owner
  end

  test "deleting an account whose household has members asks to hand it over first" do
    log_in_as(@owner)
    delete users_url(**L)

    assert_redirected_to household_url(anchor: "transfer", **L)
    assert_equal I18n.t("users.destroy.transfer_first"), flash[:alert]
    assert User.exists?(@owner.id)

    follow_redirect!
    assert_select "#transfer form[action='#{users_path}']"
    delete users_url(**L), params: { household: "delete" }
    assert_not User.exists?(@owner.id)
    assert_not Household.exists?(@household.id)
    assert_not HouseholdMembership.exists?(user_id: @mom.id)
  end
end
