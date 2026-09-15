require "application_system_test_case"

# The sign-in helpers let users find their own typos without the page revealing
# whether an account exists.
class SignInFormTest < ApplicationSystemTestCase
  setup do
    visit new_session_url(locale: I18n.default_locale)
  end

  test "a failed sign-in keeps the email, marks both fields and explains" do
    find("#email_address").set("one@example.com")
    find("#password").set("wrong-password")
    click_on I18n.t("sessions.new.submit_button")

    assert_text I18n.t("sessions.create.alert_invalid_credentials")
    assert_equal "one@example.com", find("#email_address").value
    assert_equal "", find("#password").value
    assert_selector "#email_address[aria-invalid='true']"
    assert_selector "#password[aria-invalid='true']"
  end

  test "the password can be shown and hidden again" do
    find("#password").set("secret123")

    click_on I18n.t("sessions.new.show_password")
    assert_selector "#password[type='text']"
    assert_equal "secret123", find("#password").value

    click_on I18n.t("sessions.new.hide_password")
    assert_selector "#password[type='password']"
  end

  test "a warning appears while Caps Lock is on" do
    assert_no_selector "#caps_lock_warning"
    press_key_on_password(caps_lock: true)
    assert_selector "#caps_lock_warning", text: I18n.t("sessions.new.caps_lock_on")
    press_key_on_password(caps_lock: false)
    assert_no_selector "#caps_lock_warning"
  end

  test "a likely typo in the email domain gets a suggestion that can be applied" do
    find("#email_address").set("cat@gmial.com")
    find("#password").click # leaving the email field checks it

    click_on I18n.t("sessions.new.email_suggestion", email: "cat@gmail.com")
    assert_equal "cat@gmail.com", find("#email_address").value
    assert_no_selector "#email_suggestion"
  end

  test "no suggestion for a correct or an unfamiliar domain" do
    [ "cat@gmail.com", "cat@mycompany.com", "cat@me.com" ].each do |email|
      find("#email_address").set(email)
      find("#password").click
      assert_no_selector "#email_suggestion"
    end
  end

  private
    # Selenium can't switch the real Caps Lock, so send the key event the browser would.
    def press_key_on_password(caps_lock:)
      page.execute_script(<<~JS, caps_lock)
        document.getElementById("password").dispatchEvent(
          new KeyboardEvent("keyup", { key: "a", modifierCapsLock: arguments[0], bubbles: true }))
      JS
    end
end
