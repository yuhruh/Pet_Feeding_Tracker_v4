require "test_helper"
require "minitest/mock"

# The test cache is a null store, so these tests make the store report a count over the limit.
class RateLimitTest < ActionDispatch::IntegrationTest
  OVER_LIMIT = 1_000

  test "password reset requests are rate-limited without sending mail" do
    over_limit do
      assert_no_enqueued_emails do
        post passwords_url(locale: I18n.default_locale), params: { email_address: users(:one).email_address }
      end
    end
    assert_redirected_to new_password_url(locale: I18n.default_locale)
    assert_equal I18n.t("passwords.create.alert_rate_limit"), flash[:alert]
  end

  test "an unknown email gets the same rate-limit response as a registered one" do
    over_limit { post passwords_url(locale: I18n.default_locale), params: { email_address: "nobody@example.com" } }
    unknown = [ response.status, response.location, flash[:alert] ]

    over_limit { post passwords_url(locale: I18n.default_locale), params: { email_address: users(:one).email_address } }
    assert_equal unknown, [ response.status, response.location, flash[:alert] ]
  end

  test "sign-ups are rate-limited" do
    over_limit do
      assert_no_difference("User.count") do
        post registrations_url(locale: I18n.default_locale), params: { user: { username: "new_user", email_address: "new@example.com",
          email_address_confirmation: "new@example.com", password: "password", password_confirmation: "password", timezone: "UTC" } }
      end
    end
    assert_redirected_to new_registrations_url(locale: I18n.default_locale)
    assert_equal I18n.t("registrations.create.alert_rate_limit"), flash[:alert]
  end

  test "CSV imports are rate-limited" do
    log_in_as users(:one)
    pet = pets(:one)
    over_limit do
      assert_no_difference("Tracker.count") do
        post import_pet_trackers_url(pet, locale: I18n.default_locale), params: { file: fixture_file_upload("trackers.csv", "text/csv") }
      end
    end
    assert_redirected_to pet_trackers_url(pet, locale: I18n.default_locale)
    assert_equal I18n.t("trackers.import.alert_rate_limit"), flash[:alert]
  end

  test "kibble price refreshes are rate-limited without queuing a search" do
    log_in_as users(:one)
    pet = pets(:one)
    over_limit do
      assert_no_enqueued_jobs(only: PetKibblePriceJob) do
        post pet_kibble_prices_url(pet, locale: I18n.default_locale)
      end
    end
    assert_redirected_to pet_kibble_prices_url(pet, locale: I18n.default_locale)
    assert_equal I18n.t("kibble_prices.create.rate_limited"), flash[:alert]
  end

  test "requests under the limit still go through" do
    assert_enqueued_emails 1 do
      post passwords_url(locale: I18n.default_locale), params: { email_address: users(:one).email_address }
    end
    assert_equal I18n.t("passwords.create.notice"), flash[:notice]
  end

  # Sharing a vet visit by email shows which addresses have an account.
  test "sharing vet visits with new addresses is rate-limited; saving without them is not" do
    owner, pet = users(:one), pets(:one)
    log_in_as owner

    over_limit do
      assert_no_difference("VetVisit.count") do
        post pet_vet_visits_url(pet), params: { vet_visit: { question: "q?", visit_date: Date.current, member_emails: [ "someone@example.net" ] } }
      end
      assert_redirected_to pet_vet_visits_url(pet)
      assert_equal I18n.t("vet_visits.alert_rate_limit"), flash[:alert]

      assert_difference("VetVisit.count", 1) do
        post pet_vet_visits_url(pet), params: { vet_visit: { question: "q?", visit_date: Date.current, member_emails: [ "" ] } }
      end
    end
  end

  test "sharing another visit with someone the cat's visits are already shared with is not rate-limited" do
    owner, pet, friend = users(:one), pets(:one), users(:two)
    VetVisit.create!(pet: pet, question: "first?", visit_date: Date.current).members << friend
    log_in_as owner

    over_limit do
      assert_difference("VetVisit.count", 1) do
        post pet_vet_visits_url(pet), params: { vet_visit: { question: "second?", visit_date: Date.current, member_emails: [ friend.email_address.upcase ] } }
      end
    end
    assert_equal [ friend ], VetVisit.order(:id).last.members.to_a
  end

  test "one save looks up at most 10 new addresses" do
    owner, pet, friend = users(:one), pets(:one), users(:two)
    log_in_as owner
    emails = Array.new(VetVisitsController::MAX_NEW_MEMBERS_PER_SAVE) { |i| "nobody#{i}@example.net" } + [ friend.email_address ]

    post pet_vet_visits_url(pet), params: { vet_visit: { question: "q?", visit_date: Date.current, member_emails: emails } }
    assert_empty VetVisit.order(:id).last.members, "the 11th address wasn't looked up"
  end

  private
    def over_limit(&block)
      Rails.cache.stub(:increment, OVER_LIMIT, &block)
    end
end
