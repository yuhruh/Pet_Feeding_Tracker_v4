# Household live updates re-check who may listen (see HouseholdStreamAccess).
Rails.application.config.to_prepare do
  Turbo::StreamsChannel.prepend HouseholdStreamAccess unless Turbo::StreamsChannel < HouseholdStreamAccess
end
