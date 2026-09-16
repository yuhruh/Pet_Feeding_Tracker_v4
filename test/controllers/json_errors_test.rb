require "test_helper"
require "minitest/mock"

# JSON errors always have an "error" message, plus "details" by field for validation errors.
class JsonErrorsTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @pet = pets(:one)
    log_in_as @user
  end

  test "validation errors list the message and the fields" do
    post pets_url(format: :json), params: { pet: { petname: "" } }
    assert_response :unprocessable_entity
    body = response.parsed_body
    assert_equal Pet.new(user: @user).tap(&:validate).errors.full_messages.to_sentence, body["error"]
    assert body["details"]["petname"].present?
  end

  test "another user's pet gets a JSON not-found error" do
    get pet_trackers_url(pets(:two), format: :json)
    assert_response :not_found
    assert_equal({ "error" => I18n.t("pets.not_found") }, response.parsed_body)
  end

  test "a missing tracker gets a JSON not-found error, and HTML goes back to the list" do
    get pet_tracker_url(@pet, id: 0, format: :json)
    assert_response :not_found
    assert_equal({ "error" => I18n.t("trackers.set_tracker.alert") }, response.parsed_body)

    get pet_tracker_url(@pet, id: 0)
    assert_redirected_to pet_trackers_url(@pet)
  end

  test "a missing health check gets a JSON not-found error" do
    get pet_health_check_url(@pet, id: 0, format: :json)
    assert_response :not_found
    assert_equal({ "error" => I18n.t("health_checks.not_found") }, response.parsed_body)
  end

  test "a missing dry food gets a JSON not-found error" do
    get dry_food_url(id: 0, format: :json)
    assert_response :not_found
    assert_equal({ "error" => I18n.t("dry_foods.not_found") }, response.parsed_body)
  end

  test "a failed photo extraction is not reported as a success" do
    failing_service = Object.new
    failing_service.define_singleton_method(:call) { { error: "Gemini is unavailable" } }
    GeminiOcrService.stub(:new, ->(*) { failing_service }) do
      post extract_data_pet_health_checks_url(@pet), params: { files: [ fixture_file_upload("lab_report.png", "image/png") ] }
    end
    assert_response :unprocessable_entity
    assert_equal({ "error" => "Gemini is unavailable" }, response.parsed_body)
  end
end
