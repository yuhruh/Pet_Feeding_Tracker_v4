require "test_helper"
require "minitest/mock"

# The sign-in form must not reveal which emails have accounts, or how they sign in,
# while still helping users spot their own typos.
class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # password "password123"; has a linked sign-in provider (connected_services.yml)
  end

  test "a fresh sign-in page marks nothing as wrong" do
    get new_session_url(locale: I18n.default_locale)
    assert_select "[aria-invalid]", count: 0
    assert_select "input#email_address[autofocus]"
  end

  test "an unknown email and a wrong password get exactly the same response" do
    post session_url, params: { email_address: "nobody@example.com", password: "whatever123" }
    unknown_email = failure_snapshot

    post session_url, params: { email_address: @user.email_address, password: "wrong-password" }
    wrong_password = failure_snapshot

    assert_equal unknown_email, wrong_password
    assert_equal 422, unknown_email[:status]
    assert_includes unknown_email[:alert], I18n.t("sessions.create.alert_invalid_credentials")
    assert_equal %w[email_address password], unknown_email[:marked_fields] # both, never just one
  end

  test "a failed sign-in keeps the typed email but never sends the password back" do
    post session_url, params: { email_address: "Cat@Exmaple.com", password: "secret-guess" }
    assert_select "input#email_address[value=?]", "Cat@Exmaple.com"
    assert_select "input#password:not([value])"
    assert_not_includes response.body, "secret-guess"
    assert_select "input#password[autofocus]" # the email is already filled in
  end

  test "a failed sign-in never names the providers an account uses" do
    provider = @user.connected_services.first.provider
    post session_url, params: { email_address: @user.email_address, password: "wrong-password" }
    assert_includes failure_snapshot[:alert], I18n.t("sessions.create.alert_invalid_credentials")
    assert_not_includes response.body, provider
  end

  test "an unknown email still does the password-hashing work, so timing doesn't reveal it" do
    hashes = 0
    original = BCrypt::Password.method(:create)
    BCrypt::Password.stub(:create, ->(*args, **options) { hashes += 1; original.call(*args, **options) }) do
      post session_url, params: { email_address: "nobody@example.com", password: "whatever123" }
    end
    assert_operator hashes, :>=, 1
  end

  test "a blank or missing password gets the same message" do
    post session_url, params: { email_address: @user.email_address, password: "" }
    assert_includes failure_snapshot[:alert], I18n.t("sessions.create.alert_invalid_credentials")

    post session_url, params: { email_address: @user.email_address }
    assert_includes failure_snapshot[:alert], I18n.t("sessions.create.alert_invalid_credentials")
  end

  test "correct credentials still sign in, whatever the email's letter case" do
    post session_url, params: { email_address: @user.email_address.upcase, password: "password123" }
    assert_redirected_to pets_url(locale: I18n.default_locale)
    assert_equal I18n.t("sessions.create.notice_welcome_back", username: @user.username.capitalize), flash[:notice]
  end

  private
    # Everything about a failed sign-in except the echo of the email the user typed.
    def failure_snapshot
      page = response.parsed_body
      {
        status: response.status,
        alert: page.css("[role=alert]").text.squish,
        marked_fields: page.css("[aria-invalid=true]").map { |field| field["name"] }.sort
      }
    end
end
