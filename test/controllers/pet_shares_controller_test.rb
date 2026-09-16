require "test_helper"

# Share links can be turned on with an expiry, replaced, and turned off, and only
# the owner can do any of that.
class PetSharesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @pet = pets(:one) # shared, token "token_one"
  end

  test "new pets are not shared until the owner turns on a link" do
    pet = @user.pets.create!(petname: "Mochi")
    assert_nil pet.share_token
    assert_not pet.sharing?
  end

  test "the owner can turn sharing off, and the old link stops working" do
    log_in_as @user
    old_token = @pet.share_token

    delete pet_share_url(@pet)
    assert_redirected_to pet_trackers_url(@pet)
    assert_not @pet.reload.sharing?

    assert_shared_page_missing old_token
  end

  test "creating a new link replaces the old one" do
    log_in_as @user
    old_token = @pet.share_token

    post pet_share_url(@pet), params: { expires_in: "never" }
    assert_redirected_to pet_trackers_url(@pet)
    @pet.reload
    assert @pet.sharing?
    assert_not_equal old_token, @pet.share_token
    assert_nil @pet.share_expires_at

    assert_shared_page_missing old_token
    get shared_pet_trackers_url(share_token: @pet.share_token)
    assert_response :success
  end

  test "a link with an expiry stops working once it expires" do
    log_in_as @user
    post pet_share_url(@pet), params: { expires_in: "7_days" }
    @pet.reload
    assert_in_delta 7.days.from_now.to_i, @pet.share_expires_at.to_i, 60

    travel 6.days do
      get shared_pet_trackers_url(share_token: @pet.share_token)
      assert_response :success
    end

    travel 7.days + 1.minute do
      assert_shared_page_missing @pet.share_token
      assert @pet.share_expired?
    end
  end

  test "an unknown duration is refused and leaves the link unchanged" do
    log_in_as @user
    assert_no_changes -> { @pet.reload.share_token } do
      post pet_share_url(@pet), params: { expires_in: "forever-and-ever" }
    end
    assert_equal I18n.t("pet_shares.create.invalid_duration"), flash[:alert]
  end

  test "another user cannot change a pet's share link" do
    log_in_as users(:two)

    assert_no_changes -> { @pet.reload.share_token } do
      delete pet_share_url(@pet)
      assert_redirected_to pets_url
      post pet_share_url(@pet), params: { expires_in: "never" }
      assert_redirected_to pets_url
    end
  end

  test "signed-out visitors cannot change a share link" do
    assert_no_changes -> { @pet.reload.share_token } do
      delete pet_share_url(@pet, locale: I18n.default_locale)
    end
    assert_redirected_to new_session_url(locale: I18n.default_locale)
  end

  test "the trackers page shows the share settings for the current state" do
    log_in_as @user
    get pet_trackers_url(@pet)
    assert_select "#share_settings p", text: I18n.t("trackers.index.share_settings.status_no_expiry")
    assert_select "button", text: I18n.t("trackers.index.share_link")
    assert_select "button", text: I18n.t("trackers.index.share_settings.turn_off_button")

    delete pet_share_url(@pet)
    get pet_trackers_url(@pet)
    assert_select "#share_settings p", text: I18n.t("trackers.index.share_settings.status_off")
    assert_select "button", text: I18n.t("trackers.index.share_link"), count: 0
    assert_select "button", text: I18n.t("trackers.index.share_settings.turn_on_button")
  end

  test "share tokens are unique" do
    assert_raises(ActiveRecord::RecordNotUnique) do
      pets(:two).update_column(:share_token, @pet.share_token)
    end
  end

  private
    def assert_shared_page_missing(token)
      get shared_pet_trackers_url(share_token: token)
      assert_response :not_found
    end
end
