# The monthly list of current prices for a pet's favorite kibbles.
class KibblePriceMailer < ApplicationMailer
  helper KibblePricesHelper

  # Users don't store a language, so the email follows their time zone.
  LOCALE_BY_TIME_ZONE = { "Asia/Taipei" => :"zh-TW", "Asia/Tokyo" => :ja }.freeze

  def monthly_report(check)
    @check = check
    @pet = check.pet
    @user = @pet.owner

    I18n.with_locale(LOCALE_BY_TIME_ZONE.fetch(@user.timezone.to_s, I18n.default_locale)) do
      @petname = @pet.petname.split(" ").map(&:capitalize).join(" ")
      @page_url = pet_kibble_prices_url(@pet, locale: I18n.locale)
      mail(to: @user.email_address, subject: t(".subject", petname: @petname))
    end
  end
end
