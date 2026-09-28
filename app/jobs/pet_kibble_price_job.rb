# Checks current prices for one pet's favorite kibbles and saves them as a KibblePriceCheck.
class PetKibblePriceJob < ApplicationJob
  queue_as :default

  # One pet at a time across all users, so BigGo and PChome only ever see a slow
  # trickle of requests. The lock is released after the duration if a run dies.
  limits_concurrency key: "kibble_price_search", duration: 15.minutes

  # notify: email the owner the results (the monthly run); "Refresh now" doesn't,
  # as the owner is already on the page.
  def perform(pet, checked_on = Date.current, notify: false)
    # At most one check per pet a day: the unique index settles two runs racing.
    check = pet.kibble_price_checks.create!(checked_on: checked_on)
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique
    Rails.logger.info("[PetKibblePriceJob] pet #{pet.id} already checked on #{checked_on}")
  else
    run(check)
    KibblePriceMailer.monthly_report(check).deliver_later if notify && check.kibble_prices.exists?
  end

  private

  def run(check)
    results = KibblePrices::Lookup.new(check.pet).call

    KibblePriceCheck.transaction do
      results.each do |result|
        result[:prices].each { |row| check.kibble_prices.create!(price_attributes(result[:kibble], row)) }
      end
      check.update!(status: :done, kibbles: results.map { |result| summary(result) })
    end
  rescue => e
    check.update_columns(status: "failed", error_message: "#{e.class}: #{e.message}".truncate(250), updated_at: Time.current)
    raise
  end

  def price_attributes(kibble, row)
    {
      brand: kibble[:brand], description: kibble[:description], favorite_score: kibble[:results].first[:favorite_score],
      source: row[:source], store: row[:store], url: row[:url], product_title: row[:title], variant: row[:variant],
      price_twd: row[:price_twd], bag_size_label: row[:bag_size_label], bag_size_kg: row[:bag_size_kg],
      price_per_kg: row[:price_per_kg]
    }
  end

  # What the page needs to list every kibble checked, including one with no prices.
  def summary(result)
    kibble = result[:kibble]
    {
      "brand" => kibble[:brand], "description" => kibble[:description],
      "favorite_score" => kibble[:results].first[:favorite_score],
      "queries" => result[:queries], "found" => result[:prices].size
    }
  end
end
