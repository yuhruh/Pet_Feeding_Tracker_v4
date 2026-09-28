# A plain test email, so a real send can be verified end to end after changing
# mail settings: bin/rails gmail:test_email
class DiagnosticsMailer < ApplicationMailer
  def test_email(to:, sent_at: Time.current)
    @sent_at = sent_at
    mail(to: to, subject: "Pet Tracker test email (#{sent_at.utc.strftime('%Y-%m-%d %H:%M UTC')})") do |format|
      format.text { render plain: "Sent from #{Rails.env} at #{sent_at.utc}. If you can read this, outgoing mail works." }
    end
  end

  # A kibble price source (BigGo, PChome) answered, but not in the shape the parser
  # expects: its page layout or API has probably changed.
  def price_source_alert(source:, query:, detail:)
    mail(to: ApplicationMailer.default[:from], subject: "Pet Tracker: #{source} kibble prices need attention") do |format|
      format.text do
        render plain: <<~TEXT
          #{source} returned nothing the kibble price parser could read (#{Rails.env}, #{Time.current.utc}).

          Search: #{query}
          Detail: #{detail}

          Its page layout or API has probably changed. Check the selectors in app/services/kibble_prices/.
          This alert is sent at most once a day per source.
        TEXT
      end
    end
  end
end
