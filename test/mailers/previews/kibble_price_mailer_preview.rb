# Preview all emails at http://localhost:3000/rails/mailers/kibble_price_mailer
class KibblePriceMailerPreview < ActionMailer::Preview
  # The latest finished price check, e.g. one from PetKibblePriceJob.perform_now(pet).
  # It's in the owner's language, which follows their time zone (see KibblePriceMailer).
  def monthly_report
    check = KibblePriceCheck.done.latest_first.first
    raise "No finished kibble price check yet: run PetKibblePriceJob.perform_now(pet) first" if check.nil?

    KibblePriceMailer.monthly_report(check)
  end
end
