require "test_helper"

# The nav bar's "My household" menu: owners get Today, the household page and
# care records there (on desktop and in the mobile menu); anyone without a
# household of their own keeps a plain Today link.
class HouseholdNavTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  test "an owner gets the My household menu, and the household left the account menu" do
    log_in_as(users(:one))
    get users_url(**L)

    assert_select ".btn[data-target=btn-household]", text: /My household/
    assert_select ".btn[data-target=btn-household]", text: /🏠/, count: 0
    assert_select "#btn-household a[href='#{today_path(**L)}']", text: "📅 Today"
    assert_select "#btn-household a[href='#{household_path(**L)}']", text: "🏠 Household settings"
    assert_select "#btn-household a[href='#{household_care_records_path(**L)}']", text: "📋 Care records"
    assert_select "#btn-1 a[href='#{household_path(**L)}']", count: 0
    assert_select "#menu a[href='#{household_care_records_path(**L)}']", text: "📋 Care records"
  end

  test "a caregiver without a household keeps a plain Today link" do
    mom = User.create!(username: "mom", email_address: "mom@example.com", email_address_confirmation: "mom@example.com",
                       password: "password123", timezone: "Asia/Taipei")
    households(:one).memberships.create!(user: mom, role: :caregiver)
    log_in_as(mom)
    get today_url(**L)

    assert_select ".btn[data-target=btn-household]", count: 0
    assert_select "nav a[href='#{today_path(**L)}']", text: "Today"
    assert_select "a[href='#{household_care_records_path(**L)}']", count: 0
  end

  test "the care records button on the household page is amber" do
    log_in_as(users(:one))
    get household_url(**L)

    assert_select "#care_records a.bg-amber-200.text-amber-700[href='#{household_care_records_path(**L)}']"
  end
end
