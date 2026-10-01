# An owner's or caregiver's own reminders for one household, on or off
# (checkpoint H). Viewers and anyone else can't.
class ReminderSettingsController < ApplicationController
  def update
    household = Household.reachable_by(Current.user).find_by(id: params[:household_id])
    policy = household && HouseholdPolicy.new(Current.user, household)
    return redirect_to(today_path, alert: t("care_events.not_allowed")) unless policy&.can?(:record_care)

    enabled = ActiveModel::Type::Boolean.new.cast(params[:enabled]) || false
    if policy.owner?
      household.update!(owner_reminders_enabled: enabled)
    else
      household.memberships.caregiver.find_by!(user: Current.user).update!(reminders_enabled: enabled)
    end
    redirect_to today_path, notice: t(enabled ? ".on" : ".off", household: helpers.household_name(household))
  end
end
