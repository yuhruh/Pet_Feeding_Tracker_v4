require "test_helper"

class HouseholdPolicyTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  setup do
    @household = households(:one)
    @owner = users(:one)
    @caregiver = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                              password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: @caregiver, role: :caregiver)
  end

  test "roles and what each may do" do
    viewer = User.create!(username: "gran", email_address: "gran@example.com", email_address_confirmation: "gran@example.com",
                          password: "password123", timezone: "Asia/Taipei")
    @household.memberships.create!(user: viewer, role: :viewer)

    owner, caregiver, viewer_policy, outsider =
      [ @owner, @caregiver, viewer, users(:two) ].map { |user| HouseholdPolicy.new(user, @household) }

    assert_equal [ :owner, :caregiver, :viewer, nil ], [ owner, caregiver, viewer_policy, outsider ].map(&:role)
    assert owner.can?(:manage_trackers) && owner.can?(:manage_health) && owner.can?(:view_kibble_prices)
    assert caregiver.can?(:view_trackers) && caregiver.can?(:view_charts)
    assert_not caregiver.can?(:manage_trackers) || caregiver.can?(:export_trackers) || caregiver.can?(:manage_health)
    assert viewer_policy.can?(:view_charts)
    assert_not viewer_policy.can?(:view_trackers)
    assert_not outsider.can?(:view_charts)
    assert_not HouseholdPolicy.new(nil, @household).can?(:view_charts)
  end

  test "pets a user can reach: their own household's and ones they help with" do
    assert_equal [ pets(:one) ], Pet.accessible_by(@caregiver).to_a
    assert_equal [], Pet.owned_by(@caregiver).to_a
    assert_equal [ pets(:one) ], Pet.accessible_by(@owner).to_a
    assert_not_includes Pet.accessible_by(users(:two)), pets(:one)
  end

  test "owner-only emails and names don't reach caregivers" do
    pets(:one).trackers.create!(date: Date.current, food_type: "Kibble", brand: "曙光", description: "鴨肉", amount: 30)

    UserBackupJob.perform_now
    backups_for = enqueued_jobs.select { |job| job["job_class"] == "ActionMailer::MailDeliveryJob" }
                               .map { |job| GlobalID::Locator.locate(job["arguments"].last["args"].first["_aj_globalid"]) }
    assert_includes backups_for, @owner
    assert_not_includes backups_for, @caregiver, "backups go to the owner, not the caregiver"
    assert_equal [ "曙光" ], KibblePrices::BrandNames.for_user(@owner).flat_map(&:to_a)
    assert_empty KibblePrices::BrandNames.for_user(@caregiver)
    assert_empty @caregiver.owned_pets
    assert_equal @owner, pets(:one).owner
  end
end
