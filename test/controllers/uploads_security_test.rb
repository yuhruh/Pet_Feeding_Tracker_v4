require "test_helper"

# Storing files on the server needs a signed-in person, and a cat's photo must
# be a picture of a sensible size.
class UploadsSecurityTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @pet = pets(:one)
  end

  def ask_for_direct_upload
    post rails_direct_uploads_url, as: :json,
         params: { blob: { filename: "cat.png", byte_size: 5, checksum: Base64.strict_encode64(Digest::MD5.digest("hello")), content_type: "image/png" } }
  end

  test "direct uploads are refused without signing in" do
    assert_no_difference("ActiveStorage::Blob.count") { ask_for_direct_upload }
    assert_response :unauthorized
  end

  test "direct uploads work when signed in, and stop when the session has expired" do
    log_in_as @user
    assert_difference("ActiveStorage::Blob.count", 1) { ask_for_direct_upload }
    assert_response :success
    assert response.parsed_body.dig("direct_upload", "url").present?

    travel Session::ABSOLUTE_TIMEOUT + 1.day do
      assert_no_difference("ActiveStorage::Blob.count") { ask_for_direct_upload }
      assert_response :unauthorized
    end
  end

  test "a photo is accepted and shown in the cat list" do
    log_in_as @user
    patch pet_path(@pet), params: { pet: { pet_avatar: fixture_file_upload("test_avatar.png", "image/png") } }
    assert @pet.reload.pet_avatar.attached?
    get pets_path
    assert_response :success
    assert_select "##{ActionView::RecordIdentifier.dom_id(@pet)} img"
  end

  test "a file that isn't a picture is refused, whatever type the browser claims" do
    log_in_as @user
    page = Rack::Test::UploadedFile.new(StringIO.new("<html><script>alert(1)</script></html>"), "image/png", original_filename: "cat.png")
    patch pet_path(@pet), params: { pet: { pet_avatar: page } }
    assert_response :unprocessable_entity
    assert_not @pet.reload.pet_avatar.attached?
    assert_includes response.body, I18n.t("activerecord.errors.models.pet.attributes.pet_avatar.not_an_image")
  end

  test "a photo over the size limit is refused" do
    stub_const(Pet, :AVATAR_MAX_SIZE, 10) do
      @pet.pet_avatar.attach(io: file_fixture("test_avatar.png").open, filename: "cat.png", content_type: "image/png")
      assert_not @pet.valid?
      assert_equal [ I18n.t("activerecord.errors.models.pet.attributes.pet_avatar.too_large", megabytes: 0) ], @pet.errors[:pet_avatar]
    end
  end

  test "a cat that already has a file that isn't a picture still lists and can be edited" do
    blob = ActiveStorage::Blob.create_and_upload!(io: StringIO.new("<html></html>"), filename: "old.html", content_type: "text/html", identify: false)
    ActiveStorage::Attachment.create!(name: "pet_avatar", record: @pet, blob: blob)
    log_in_as @user

    get pets_path
    assert_response :success
    assert_select "##{ActionView::RecordIdentifier.dom_id(@pet)} img", count: 0

    patch pet_path(@pet), params: { pet: { petname: "Mochi" } }
    assert_equal "Mochi", @pet.reload.petname
  end
end
