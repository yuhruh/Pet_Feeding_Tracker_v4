# Every household the user owns or belongs to, their own first: buttons for each
# litter box, water spot and cat, and today's timeline.
class TodayController < ApplicationController
  def show
    households = [ Current.user.owned_household, *Current.user.member_households.includes(:owner).order(:id) ].compact
    @roles = Current.user.household_memberships.pluck(:household_id, :role).to_h
    @days = households.map { |household| HouseholdDay.new(household) }
    @reminder_channel = Current.user.connected_services.exists?(provider: "line") ? "line" : "email"

    reachable = Household.reachable_by(Current.user).select(:id)
    @saved_event = CareEvent.kept.where(household_id: reachable).find_by(id: flash[:care_event_id]) if flash[:care_event_id]
    @repeat = flash[:care_repeat]&.then { |prompt| prompt.merge("event" => CareEvent.where(household_id: reachable).find_by(id: prompt["repeat_id"])) }
  end
end
