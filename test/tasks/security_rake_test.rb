require "test_helper"
require "rake"

class SecurityRakeTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  setup do
    Rails.application.load_tasks unless Rake::Task.task_defined?("security:force_password_reset")
    @task = Rake::Task["security:force_password_reset"]
    @user = users(:one) # password "password123"
    @other = users(:two)
    @session = @user.sessions.create!
  end

  teardown do
    @task.reenable
    ENV.delete("EMAILS")
    ENV.delete("CONFIRM")
  end

  test "without CONFIRM it changes nothing" do
    ENV["EMAILS"] = @user.email_address
    assert_no_emails do
      assert_output(/Dry run\. Would reset 1 account/) { @task.invoke }
    end
    assert @user.reload.authenticate("password123")
    assert Session.exists?(@session.id)
  end

  test "with CONFIRM it replaces the password, ends every session and sends the email" do
    ENV["EMAILS"] = " ONE@example.com , nobody@example.com"
    ENV["CONFIRM"] = "1"
    old_reset_token = @user.password_reset_token

    assert_emails 1 do
      assert_output(/No account for: nobody@example.com.*Reset and emailed one@example.com/m) { @task.invoke }
    end
    assert_not @user.reload.authenticate("password123")
    assert_not Session.exists?(@session.id)
    assert_raises(ActiveSupport::MessageVerifier::InvalidSignature) { User.find_by_password_reset_token!(old_reset_token) }
    assert @other.reload.authenticate("password123"), "accounts not listed are untouched"
  end
end
