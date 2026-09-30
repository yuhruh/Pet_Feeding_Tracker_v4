module HouseholdsHelper
  # "Rita's cats", in the reader's language, unless the owner named the household.
  def household_name(household)
    household.name.presence || t("households.default_name", owner: household.owner.username.split(" ").map(&:capitalize).join(" "))
  end
end
