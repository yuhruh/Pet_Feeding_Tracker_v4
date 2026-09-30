# Every household the user owns or belongs to, their own first, with each cat.
# Checkpoint D adds the one-tap buttons and today's timeline.
class TodayController < ApplicationController
  def show
    @households = [ Current.user.owned_household, *Current.user.member_households.includes(:owner).order(:id) ].compact
    @roles = Current.user.household_memberships.pluck(:household_id, :role).to_h
    @pets = Pet.where(household_id: @households.map(&:id)).order(:petname).group_by(&:household_id)
  end
end
