require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "welcome_email" do
    mail = UserMailer.with(user: users(:one)).welcome_email
    assert_equal "Welcome to Cat Trackers App!", mail.subject
    assert_equal [ users(:one).email_address ], mail.to
    assert_equal [ "ajicaretracker@gmail.com" ], mail.from
    assert_match /Welcome to Cat Tracker App/, mail.html_part.body.decoded
  end

  test "send_pet_weight_reminder" do
    mail = UserMailer.with(user: users(:one), subject: "⚖️ 該幫Aji量體重囉", lines: [ "Aji：上次量體重是 10/1，已經 14 天了。" ],
                           url: "http://example.com/zh-TW/pets/1/trackers", locale: "zh-TW").send_pet_weight_reminder
    assert_equal "⚖️ 該幫Aji量體重囉", mail.subject
    assert_equal [ users(:one).email_address ], mail.to
    assert_equal [ "ajicaretracker@gmail.com" ], mail.cc
    assert_equal [ "ajicaretracker@gmail.com" ], mail.from
    assert_includes mail.html_part.body.decoded, "上次量體重是 10/1"
    assert_includes mail.html_part.body.decoded, "http://example.com/zh-TW/pets/1/trackers"
    assert_includes mail.text_part.body.decoded, "userone 您好"
  end
end
