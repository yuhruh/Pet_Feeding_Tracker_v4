require "test_helper"

# The saved Gemini key never goes back to the browser: the profile form holds a
# stand-in. Unchanged keeps the key, blank removes it, anything else replaces it.
class GeminiKeyFormTest < ActionDispatch::IntegrationTest
  KEY = "AIzaSyTESTKEY0123456789".freeze

  setup do
    @user = users(:one)
    @user.update!(gemini_api_key: KEY)
    log_in_as @user
  end

  def save_profile(key) = patch(users_path, params: { user: { username: @user.username, gemini_api_key: key } })

  test "the edit page doesn't contain the key" do
    get edit_users_path
    assert_not_includes response.body, KEY
    assert_select "input[name='user[gemini_api_key]'][type=password][value=?]", User::SAVED_GEMINI_KEY_MASK
  end

  test "with no saved key the field is empty" do
    @user.update!(gemini_api_key: nil)
    get edit_users_path
    assert_select "input[name='user[gemini_api_key]']" do |fields|
      assert fields.first["value"].blank?
    end
  end

  test "saving the form untouched keeps the key" do
    save_profile(User::SAVED_GEMINI_KEY_MASK)
    assert_redirected_to users_path
    assert_equal KEY, @user.reload.gemini_api_key
  end

  test "clearing the field removes the key, and typing a new one replaces it" do
    save_profile("AIzaSyANOTHERKEY987654321")
    assert_equal "AIzaSyANOTHERKEY987654321", @user.reload.gemini_api_key

    save_profile("")
    assert @user.reload.gemini_api_key.blank?
  end

  test "a form shown again after an error still doesn't contain the key" do
    patch users_path, params: { user: { username: "", gemini_api_key: User::SAVED_GEMINI_KEY_MASK } }
    assert_response :unprocessable_entity
    assert_not_includes response.body, KEY
  end
end
