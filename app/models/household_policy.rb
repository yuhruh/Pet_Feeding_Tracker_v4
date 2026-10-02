# What a person may do with a household's cats, from their role in it. The one
# place that decides; controllers and views ask `can?`.
class HouseholdPolicy
  # The owner may do everything. A caregiver records care and reads the trackers
  # and charts; a viewer sees the charts and today's timeline.
  PERMISSIONS = {
    caregiver: %i[record_care view_trackers view_charts].freeze,
    viewer: %i[view_charts].freeze
  }.freeze

  attr_reader :user, :household

  def initialize(user, household)
    @user = user
    @household = household
  end

  # :owner, :caregiver, :viewer, or nil for someone outside the household.
  def role
    return if user.nil? || household.nil?
    return :owner if household.owner_id == user.id

    @membership_role ||= household.memberships.find_by(user_id: user.id)&.role&.to_sym
  end

  def owner?
    role == :owner
  end

  def can?(permission)
    return true if owner?

    PERMISSIONS.fetch(role, []).include?(permission)
  end
end
