# A change to this record refreshes the household's open Today and viewer pages
# (checkpoint G). The refresh carries no data: each page asks the server again,
# so everyone still sees only what their role allows. Turbo sends one refresh
# for many changes in a row (an import, deleting a cat) and skips the page whose
# own request made the change.
module RefreshesHouseholdPages
  extend ActiveSupport::Concern

  included do
    after_commit :refresh_household_pages
  end

  def refresh_household_pages
    household = household_to_refresh
    broadcast_refresh_later_to(household) if household
  end

  private

  def household_to_refresh = household
end
