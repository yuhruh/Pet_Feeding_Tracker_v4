require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email_address: "example@email.com", password: "password", password_confirmation: "password", username: "John Doe", timezone: "Asia/Taipei")
  end

  test "should get edit" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    get edit_users_url
    assert_response :success
  end

  test "should not get edit when not logged in" do
    get edit_users_url
    assert_redirected_to new_session_url
  end

  test "should update user" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    patch users_url, params: { user: { username: "new_username", password: "password", password_confirmation: "password" } }
    assert_redirected_to users_path
    @user.reload
    assert_equal "new_username", @user.username
  end

  test "should not update user when not logged in" do
    patch users_url, params: { user: { username: "new_username", password: "password", password_confirmation: "password" } }
    assert_redirected_to new_session_url
  end

  test "should destroy user" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    assert_difference("User.count", -1) do
      delete users_url
    end
    assert_redirected_to "/home"
  end

  test "should not destroy user when not logged in" do
    assert_no_difference("User.count") do
      delete users_url
    end
    assert_redirected_to new_session_url
  end
end
