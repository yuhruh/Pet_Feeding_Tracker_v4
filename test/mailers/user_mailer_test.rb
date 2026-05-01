require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "welcome_email" do
    mail = UserMailer.with(user: users(:one)).welcome_email
    assert_equal "Welcome to Cat Trackers App!", mail.subject
    assert_equal [users(:one).email_address], mail.to
    assert_equal ["ajicaretracker@gmail.com"], mail.from
    assert_match /Welcome to Cat Tracker App/, mail.html_part.body.decoded
  end

  test "send_pet_weight_reminder" do
    mail = UserMailer.send_pet_weight_reminder(users(:one))
    assert_equal "Time to weigh your pet! 📝", mail.subject
    assert_equal [users(:one).email_address], mail.to
    assert_equal ["ajicaretracker@gmail.com"], mail.from
    assert_match /Time to weigh your pet! 📝/, mail.body.decoded
  end
end
