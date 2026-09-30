require "test_helper"

class HouseholdAccessLinksTest < ActiveSupport::TestCase
  setup do
    @household = households(:one)
    @owner = users(:one)
  end

  def new_user(name)
    User.create!(username: name, email_address: "#{name}@example.com", email_address_confirmation: "#{name}@example.com",
                 password: "password123", timezone: "Asia/Taipei")
  end

  def invite(email)
    @household.invitations.create!(email: email, invited_by: @owner)
  end

  test "an invitation stores only a digest of its token and is found by the token" do
    invitation = invite(" Mom@Example.com ")

    assert invitation.token.present?
    assert_not_equal invitation.token, invitation.token_digest
    assert_equal "mom@example.com", invitation.email
    assert_equal invitation, HouseholdInvitation.find_by_token(invitation.token)
    assert_nil HouseholdInvitation.find_by_token("not-a-token")
    assert_nil HouseholdInvitation.find_by_token(nil)
    assert_nil HouseholdInvitation.find(invitation.id).token, "the token isn't kept"
    assert_in_delta 7.days.from_now, invitation.expires_at, 5
  end

  test "accepting an invitation makes that person a caregiver, once" do
    mom = new_user("mom")
    invitation = invite("mom@example.com")

    assert invitation.accept!(mom)
    assert_equal "caregiver", @household.memberships.find_by(user: mom).role
    assert_equal mom, invitation.reload.accepted_by

    assert_not invitation.accept!(mom), "single use"
    assert_equal [ { error: :not_pending } ], invitation.errors.details[:base]
  end

  test "an invitation is refused for another email, after it expires, and for the owner" do
    mom = new_user("mom")
    invitation = invite("mom@example.com")

    assert_not invitation.accept!(new_user("stranger"))
    assert_equal [ { error: :wrong_email } ], invitation.errors.details[:base]

    invitation.update!(expires_at: 1.minute.ago)
    assert_not invitation.accept!(mom)
    assert_equal [ { error: :not_pending } ], invitation.errors.details[:base]

    assert_raises(ActiveRecord::RecordInvalid) { invite(@owner.email_address) }
    @household.memberships.create!(user: mom, role: :caregiver)
    assert_raises(ActiveRecord::RecordInvalid) { invite("mom@example.com") }
  end

  test "a viewer link works until it's turned off or expires" do
    link = @household.viewer_links.create!(name: "Grandma", created_by: @owner)

    assert_equal link, ViewerLink.find_active(link.token)
    link.revoke!
    assert_nil ViewerLink.find_active(link.token)

    expiring = @household.viewer_links.create!(name: "Ken", created_by: @owner, expires_at: 1.day.from_now)
    assert expiring.active?
    expiring.update_column(:expires_at, 1.minute.ago)
    assert_nil ViewerLink.find_active(expiring.token)
    assert_raises(ActiveRecord::RecordInvalid) { @household.viewer_links.create!(name: "x", created_by: @owner, expires_at: 1.day.ago) }
  end

  test "transferring ownership swaps the owner and the member, and moves the cats and bags" do
    mom = new_user("mom")
    @household.memberships.create!(user: mom, role: :caregiver)
    transfer = @household.ownership_transfers.create!(from_user: @owner, to_user: mom)

    assert transfer.accept!(mom)
    @household.reload
    assert_equal mom, @household.owner
    assert_equal "caregiver", @household.memberships.find_by(user: @owner).role, "the former owner stays as a caregiver"
    assert_nil @household.memberships.find_by(user: mom), "the new owner isn't also a member"
    assert_equal [ mom.id ], @household.pets.distinct.pluck(:user_id)
    assert_equal [ mom.id ], @household.dry_foods.distinct.pluck(:user_id)
    assert pets(:one).reload.valid?, "the pet still belongs to its household's owner"
    assert_equal @household, mom.reload.owned_household
    assert_nil @owner.reload.owned_household
  end

  test "a transfer is only to a member who owns nothing, by that member, once" do
    mom = new_user("mom")
    assert_raises(ActiveRecord::RecordInvalid) { @household.ownership_transfers.create!(from_user: @owner, to_user: mom) }

    @household.memberships.create!(user: mom, role: :caregiver)
    transfer = @household.ownership_transfers.create!(from_user: @owner, to_user: mom)
    assert_not transfer.accept!(@owner)
    assert_equal [ { error: :wrong_person } ], transfer.errors.details[:base]

    mom.pets.create!(petname: "Kuro") # Mom now owns a household of her own
    assert_not transfer.accept!(mom)
    assert_equal [ { error: :already_owns } ], transfer.errors.details[:base]
    assert_equal @owner, @household.reload.owner
  end

  test "deleting someone who invited, accepted, created a link or was offered a transfer doesn't fail" do
    mom = new_user("mom")
    invitation = invite("mom@example.com")
    invitation.accept!(mom)
    link = @household.viewer_links.create!(name: "Grandma", created_by: @owner)
    @household.ownership_transfers.create!(from_user: @owner, to_user: mom)

    assert_difference -> { OwnershipTransfer.count } => -1 do
      mom.destroy!
    end
    assert_nil invitation.reload.accepted_by
    assert link.reload.active?
  end
end
