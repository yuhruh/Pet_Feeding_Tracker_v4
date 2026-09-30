# Emails about joining someone's household.
class HouseholdMailer < ApplicationMailer
  helper HouseholdsHelper

  # To the invited address, in the language the owner was using when inviting.
  def invitation
    @invitation = params[:invitation]
    @household = @invitation.household
    I18n.with_locale(params[:locale].presence || I18n.default_locale) do
      @owner_name = @household.owner.username.split(" ").map(&:capitalize).join(" ")
      @pet_names = @household.pets.order(:created_at).map { |pet| pet.petname.capitalize }.to_sentence
      @join_url = join_household_url(token: params[:token], locale: I18n.locale)
      mail(to: @invitation.email, subject: t(".subject", owner: @owner_name))
    end
  end
end
