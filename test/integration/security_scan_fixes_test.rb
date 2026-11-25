require "test_helper"
require "minitest/mock"

# Fixes for the Claude Security scan of 25 November 2026 (findings F2–F30 in
# the report). The Android sign-in ones (F1, F8, F28) are in native_sign_in_test.rb.
class SecurityScanFixesTest < ActionDispatch::IntegrationTest
  L = { locale: I18n.default_locale }.freeze

  setup do
    @owner = users(:one)
    @household = households(:one)
    @pet = pets(:one)
  end

  def new_user(name)
    User.create!(username: name, email_address: "#{name}@example.com", email_address_confirmation: "#{name}@example.com",
                 password: "password123", timezone: "Asia/Taipei")
  end

  def member(name, role)
    new_user(name).tap { |user| @household.memberships.create!(user: user, role: role) }
  end

  def chart_options
    css_select("[data-echart-options-value]").first&.attr("data-echart-options-value")
  end

  # F2
  test "only the owner's trackers page holds the share link" do
    @pet.share!
    log_in_as member("gran", :viewer)
    get pet_trackers_path(@pet, **L)
    assert_response :success
    assert_no_match @pet.share_token, response.body

    log_in_as @owner
    get pet_trackers_path(@pet, **L)
    assert_match @pet.share_token, response.body
  end

  # F4
  test "a viewer's chart ignores the text search, and a search's % is not a wildcard" do
    @pet.trackers.update_all(note: "secret vet note", total_ate_amount: 10)
    log_in_as member("gran", :viewer)
    get pet_trackers_path(@pet, **L)
    unfiltered = chart_options
    get pet_trackers_path(@pet, note: "no such words", **L)
    assert_equal unfiltered, chart_options, "the note filter doesn't narrow a viewer's chart"

    log_in_as @owner
    get pet_trackers_path(@pet, note: "%", **L)
    assert_no_match "secret vet note", response.body, "% matches only a literal %"
  end

  # F7
  test "a viewer can't get the owner's CSV by listing another format first" do
    log_in_as member("gran", :viewer)
    get pet_trackers_path(@pet, **L), headers: { "Accept" => "application/json, text/csv" }
    assert_not_equal "text/csv", response.media_type
  end

  # F29
  test "a bad per page from a link is ignored and not remembered" do
    log_in_as @owner
    get pet_trackers_path(@pet, per_page: 0, **L)
    assert_response :success
    get pet_trackers_path(@pet, per_page: "-1", **L)
    assert_response :success
    get favorite_food_pet_trackers_path(@pet, per_page: "abc", **L)
    assert_response :success
    assert_nil session[:per_page]

    get pet_trackers_path(@pet, per_page: 20, **L)
    assert_equal 20, session[:per_page]
  end

  # F3
  test "a member removed after an ownership offer can't accept it" do
    mom = member("mom", :caregiver)
    transfer = @household.ownership_transfers.create!(from_user: @owner, to_user: mom)
    @household.memberships.find_by!(user: mom).destroy!

    assert transfer.reload.cancelled_at, "removing the member cancels the offer"
    assert_not transfer.accept!(mom)
    assert_equal @owner, @household.reload.owner
  end

  test "accepting an offer still works, and the accepted offer isn't cancelled" do
    mom = member("mom", :caregiver)
    transfer = @household.ownership_transfers.create!(from_user: @owner, to_user: mom)
    assert transfer.accept!(mom)
    transfer.reload
    assert transfer.accepted_at
    assert_nil transfer.cancelled_at
  end

  # F6
  test "a password of spaces needs the current password and is refused" do
    log_in_as @owner
    digest = @owner.password_digest
    patch users_path(**L), params: { user: { password: " ", password_confirmation: " " } }
    assert_response :unprocessable_entity
    assert_equal digest, @owner.reload.password_digest

    patch users_path(**L), params: { user: { password: " " * 9, password_confirmation: " " * 9, current_password: "password123" } }
    assert_equal digest, @owner.reload.password_digest, "spaces are not a password"
  end

  # F15
  test "sign-in is also limited per email address" do
    # Only the per-email count is over its limit; the per-address one isn't.
    over_limit = ->(key, *) { key.to_s.include?("per_email") ? 1_000 : 1 }
    Rails.cache.stub(:increment, over_limit) do
      post session_path(**L), params: { email_address: " #{@owner.email_address.upcase} ", password: "password123" }
    end
    assert_redirected_to new_session_url(**L)
    assert_nil cookies[:session_id].presence
  end

  # F16
  def line_sign_in_without_email
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:line] = OmniAuth::AuthHash.new(provider: "line", uid: "line-someone", info: { name: "Someone" })
    post "/auth/line"
    follow_redirect!
    assert session["omniauth.auth"].present?, "kept for the sign-up page"
  end

  def sign_up(name)
    post registrations_path(**L), params: { user: { username: name, email_address: "#{name}@example.com", email_address_confirmation: "#{name}@example.com",
                                                    password: "password123", password_confirmation: "password123", timezone: "UTC" } }
    User.find_by!(email_address: "#{name}@example.com")
  end

  test "a LINE sign-in left waiting is dropped by a password sign-in, and isn't linked after a few minutes" do
    line_sign_in_without_email
    log_in_as @owner
    assert_nil session["omniauth.auth"]

    delete session_path(**L)
    line_sign_in_without_email
    travel 20.minutes do
      assert_empty sign_up("victim").connected_services
    end
  ensure
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:line] = nil
  end

  test "a LINE sign-in finished within minutes is linked, as before" do
    line_sign_in_without_email
    get new_registrations_path(**L)
    assert_select "#linking_provider"
    assert_equal [ "line" ], sign_up("lineuser").connected_services.pluck(:provider)
  ensure
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:line] = nil
  end

  test "signing out empties the browser's session" do
    log_in_as @owner
    get pet_trackers_path(@pet, per_page: 20, **L)
    assert_equal 20, session[:per_page]
    delete session_path(**L)
    assert_nil session[:per_page]
  end

  # F19
  test "a password reset cancels the household's pending offers and invitations" do
    mom = member("mom", :caregiver)
    transfer = @household.ownership_transfers.create!(from_user: @owner, to_user: mom)
    invitation = @household.invitations.create!(email: "dad@example.com", invited_by: @owner)

    patch password_path(@owner.password_reset_token, **L), params: { password: "brand-new-pass", password_confirmation: "brand-new-pass" }
    assert transfer.reload.cancelled_at
    assert_not invitation.reload.pending?
    assert_match I18n.t("passwords.update.household_reviewed"), flash[:notice]
  end

  # F22
  test "a password reset for a list of emails sends nothing" do
    assert_no_enqueued_emails do
      post passwords_path(**L), params: { email_address: [ @owner.email_address, "x@example.com" ] }
    end
  end

  # F21
  test "linking a new sign-in method to a signed-in account emails the account" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(provider: "github", uid: "gh-new", info: { email: "someone@example.com", name: "x" })
    log_in_as @owner
    assert_enqueued_email_with SecurityMailer, :sign_in_method_added, args: [ @owner, "github" ] do
      post "/auth/github"
      follow_redirect!
    end
  ensure
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:github] = nil
  end

  # F5
  test "direct uploads take only cat-photo types and sizes" do
    log_in_as @owner
    checksum = Base64.strict_encode64(Digest::MD5.digest("hello"))
    [ { content_type: "text/javascript", byte_size: 5 }, { content_type: "image/png", byte_size: Pet::AVATAR_MAX_SIZE + 1 },
      { content_type: "image/png", byte_size: "5; drop" } ].each do |blob|
      assert_no_difference("ActiveStorage::Blob.count") do
        post rails_direct_uploads_url, as: :json, params: { blob: blob.merge(filename: "x", checksum: checksum) }
      end
      assert_response :unprocessable_entity
    end
  end

  # F11
  test "a CSV import over the size limit is refused before it is read" do
    Tempfile.create([ "big", ".csv" ]) do |file|
      file.write("a" * (CsvImportTrackersService::MAX_BYTES + 1))
      file.flush
      service = CsvImportTrackersService.new(@pet, @owner)
      assert_not service.call(file.path)
      assert_match "too large", service.errors.join
    end
  end

  # F17
  test "a picture too large to resize is refused before it is decoded" do
    skip "libvips isn't installed" unless BoundedImageVariants.vips?
    Dir.mktmpdir do |dir|
      path = File.join(dir, "small.png")
      Vips::Image.black(40, 30).write_to_file(path)
      BoundedImageVariants.check!(path)
      BoundedImageVariants.stub(:max_pixels, 100) do
        assert_raises(ActiveStorage::InvariableError) { BoundedImageVariants.check!(path) }
      end
    end
  end

  # F18
  test "a person keeps one push token per sign-in and a few in all" do
    session = @owner.sessions.create!
    DeviceToken.register(user: @owner, session: session, token: "first")
    DeviceToken.register(user: @owner, session: session, token: "second")
    assert_equal [ "second" ], @owner.device_tokens.pluck(:token)

    (DeviceToken::MAX_PER_USER + 3).times { |i| DeviceToken.register(user: @owner, session: @owner.sessions.create!, token: "t#{i}") }
    assert_equal DeviceToken::MAX_PER_USER, @owner.device_tokens.count
  end

  # F20
  test "formula text after a comma inside a value is neutralized too, and restored on import" do
    value = "ok,=cmd|' /C calc'!A0,b"
    safe = CsvSafe.cell(value)
    assert_no_match(/[,;\t\r\n][=+\-@]/, safe)
    assert_equal value, CsvSafe.restore(safe)
  end

  # F13, F30
  test "vet visits answer the same for a missing pet and someone else's, and show members by email only" do
    stranger = new_user("stranger")
    log_in_as stranger
    get pet_vet_visits_path(pets(:two), **L)
    theirs = [ response.status, response.location ]
    get pet_vet_visits_path(pet_id: Pet.maximum(:id) + 100, **L)
    assert_equal theirs, [ response.status, response.location ]
  end

  # F27
  class StreamAccessTest < ActionCable::Channel::TestCase
    tests Turbo::StreamsChannel

    def household = households(:one)
    def signed = Turbo::StreamsChannel.signed_stream_name(household)

    test "a household's live updates are for its owner, members and active viewer links only" do
      stub_connection(current_user: nil)
      subscribe signed_stream_name: signed
      assert subscription.rejected?, "no account and no link"

      link = household.viewer_links.create!(name: "Gran", created_by: users(:one))
      subscribe signed_stream_name: signed, viewer_link: link.token
      assert subscription.confirmed?

      link.revoke!
      subscribe signed_stream_name: signed, viewer_link: link.token
      assert subscription.rejected?, "a revoked link stops listening"

      stub_connection(current_user: users(:two))
      subscribe signed_stream_name: signed
      assert subscription.rejected?, "someone else's account"

      stub_connection(current_user: users(:one))
      subscribe signed_stream_name: signed
      assert subscription.confirmed?
    end
  end
end
