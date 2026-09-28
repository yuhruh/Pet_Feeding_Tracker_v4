require "test_helper"

class DiagnosticsMailerTest < ActionMailer::TestCase
  test "test_email says where and when it came from" do
    sent_at = Time.utc(2026, 9, 16, 5, 30)
    mail = DiagnosticsMailer.test_email(to: "owner@example.com", sent_at: sent_at)

    assert_equal [ "owner@example.com" ], mail.to
    assert_equal [ "ajicaretracker@gmail.com" ], mail.from
    assert_equal "Pet Tracker test email (2026-09-16 05:30 UTC)", mail.subject
    assert_match "outgoing mail works", mail.body.decoded
  end

  test "price_source_alert goes to the app's own address and names the source" do
    mail = DiagnosticsMailer.price_source_alert(source: "BigGo", query: "璞斯 貓飼料", detail: "no listings")

    assert_equal [ "ajicaretracker@gmail.com" ], mail.to
    assert_equal "Pet Tracker: BigGo kibble prices need attention", mail.subject
    assert_match "璞斯 貓飼料", mail.body.decoded
    assert_match "app/services/kibble_prices/", mail.body.decoded
  end
end
