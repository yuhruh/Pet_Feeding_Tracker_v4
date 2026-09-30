# One-tap care from the Today page. The cat or spot decides the household; the
# person must be its owner or a caregiver. Each tap returns to Today, which shows
# the saved notice (Undo, Change time, Add details, the water checkboxes).
class CareEventsController < ApplicationController
  before_action :set_care_event, only: %i[edit update undo]

  def create
    subject = CareEvent.subject_for(Current.user, pet_id: params[:pet_id], care_spot_id: params[:care_spot_id])
    return refuse unless HouseholdPolicy.new(Current.user, subject.household).can?(:record_care)

    event = build_event(subject)
    return if merge_water_tap(event)

    if !params[:confirmed] && (repeat = event.recent_repeat)
      flash[:care_repeat] = repeat_prompt(event, repeat)
      return redirect_to today_path
    end

    if event.save
      saved(event)
    else
      redirect_to today_path, alert: event.errors.map(&:message).to_sentence
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to today_path, alert: t("care_events.not_found")
  end

  # "Add details" / "Change": the time, the jobs, feeding details, weight, note.
  def edit
    return refuse unless @event.editable_by?(Current.user)

    @suggestions = FeedingSuggestions.new(@event.pet).by_food_type if @event.fed?
  end

  # Change time (quick picks or a time), the water checkboxes, and details.
  def update
    return refuse unless @event.editable_by?(Current.user)

    @event.assign_attributes(change_params)
    @event.assign_attributes(edited_by: Current.user, edited_at: Time.current) if @event.changed?
    if @event.save
      flash[:care_event_id] = @event.id if params[:from_notice]
      redirect_to today_path, notice: (t(".notice") unless params[:from_notice])
    else
      redirect_to today_path, alert: @event.errors.map(&:message).to_sentence
    end
  end

  def undo
    return redirect_to(today_path, alert: t(".too_late")) unless @event.undoable_by?(Current.user)

    @event.undo!
    redirect_to today_path, notice: t(".notice")
  end

  private

  def set_care_event
    @event = CareEvent.kept.where(household_id: Household.reachable_by(Current.user).select(:id)).find_by(id: params[:id])
    redirect_to today_path, alert: t("care_events.not_found") unless @event
  end

  def build_event(subject)
    event = CareEvent.new(actor: Current.user, occurred_at: Time.current)
    if subject.is_a?(Pet)
      event.assign_attributes(pet: subject, kind: params[:kind].presence_in(%w[fed weight]))
      event.value = params[:value] if event.weight?
    else
      event.assign_attributes(care_spot: subject, kind: subject.litter_box? ? :litter : :water, actions: [ params[:care_action].to_s ])
    end
    event
  end

  # A second water tap on the same spot by the same person, within 2 minutes,
  # adds its action to the open record.
  def merge_water_tap(event)
    return false unless event.water?

    open = CareEvent.kept.water.where(care_spot: event.care_spot, actor: Current.user)
                    .where(created_at: CareEvent::WATER_MERGE_WINDOW.ago..).order(created_at: :desc).first
    return false unless open

    open.actions = (open.actions + event.actions).uniq
    open.save ? saved(open) : redirect_to(today_path, alert: open.errors.map(&:message).to_sentence)
    true
  end

  def saved(event)
    flash[:care_event_id] = event.id
    redirect_to today_path
  end

  def repeat_prompt(event, repeat)
    { "pet_id" => event.pet_id, "care_spot_id" => event.care_spot_id, "kind" => event.kind, "care_action" => event.actions.first,
      "repeat_id" => repeat.id }
  end

  # Times come as "minutes ago" (the quick picks) or a local date and time.
  def change_params
    changes = {}
    if params[:minutes_ago].present?
      changes[:occurred_at] = params[:minutes_ago].to_i.clamp(0, 60).minutes.ago
    elsif params[:occurred_at].present?
      changes[:occurred_at] = @event.household.time_zone.parse(params[:occurred_at].to_s)
    end
    changes[:actions] = Array(params[:care_actions]) if params.key?(:care_actions)
    changes[:details] = params.fetch(:details, {}).permit(*CareEvent::FED_DETAILS).to_h if params.key?(:details)
    changes[:value] = params[:value] if params.key?(:value)
    changes[:note] = params[:note].to_s.first(200) if params.key?(:note)
    changes
  end

  def refuse
    redirect_to today_path, alert: t("care_events.not_allowed")
  end
end
