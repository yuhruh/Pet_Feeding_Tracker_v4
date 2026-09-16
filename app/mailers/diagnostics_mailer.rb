# A plain test email, so a real send can be verified end to end after changing
# mail settings: bin/rails gmail:test_email
class DiagnosticsMailer < ApplicationMailer
  def test_email(to:, sent_at: Time.current)
    @sent_at = sent_at
    mail(to: to, subject: "Pet Tracker test email (#{sent_at.utc.strftime('%Y-%m-%d %H:%M UTC')})") do |format|
      format.text { render plain: "Sent from #{Rails.env} at #{sent_at.utc}. If you can read this, outgoing mail works." }
    end
  end
end
