# One-tap care from the Today page. The cat or spot decides the household; the
# person must be its owner or a caregiver. Each tap returns to Today, which shows
# the saved notice (Undo, Change time, Add details, the water checkboxes).
class CareEventsController < ApplicationController
  before_action :set_care_event, only: %i[edit update undo destroy]

  def create
    subject = CareEvent.subject_for(Current.user, pet_id: params[:pet_id], care_spot_id: params[:care_spot_id])
    policy = HouseholdPolicy.new(Current.user, subject.household)
    return refuse unless policy.can?(:record_care)
    # A one-off medicine, not on the cat's list, is the owner's call.
    return refuse if params[:kind] == "meds" && params[:medication_id].blank? && !policy.owner?

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

  # "Add details" / "Change": the time, the jobs, feeding details, litter
  # observations, weight, note.
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

  # Delete a mistaken record (checkpoint H3), after a confirmation.
  def destroy
    unless @event.deletable_by?(Current.user)
      # A caregiver learns the 24-hour rule; a viewer can't record care at all.
      caregiver = HouseholdPolicy.new(Current.user, @event.household).can?(:record_care)
      return redirect_to today_path, alert: caregiver ? t(".not_allowed") : t("care_events.not_allowed"), status: :see_other
    end

    linked_tracker = @event.tracker_id.present?
    @event.delete_by!(Current.user)
    notice = t(".notice", what: helpers.care_event_summary(@event), time: helpers.care_time(@event.occurred_at, @event.household.time_zone))
    notice = "#{notice} #{t('.tracker_kept')}" if linked_tracker
    redirect_to today_path, notice: notice, status: :see_other
  end

  private

  def set_care_event
    records = CareEvent.where(household_id: Household.reachable_by(Current.user).select(:id))
    @event = records.kept.find_by(id: params[:id])
    return if @event

    # Deleted (or undone) already, e.g. from another tab: say so, rather than "not found".
    gone = action_name == "destroy" && records.exists?(id: params[:id])
    redirect_to today_path, alert: t(gone ? "care_events.destroy.already_deleted" : "care_events.not_found"), status: :see_other
  end

  def build_event(subject)
    event = CareEvent.new(actor: Current.user, occurred_at: Time.current)
    if subject.is_a?(Pet)
      event.assign_attributes(pet: subject, kind: params[:kind].presence_in(%w[fed weight meds]))
      event.value = params[:value] if event.weight?
      assign_dose(event, subject) if event.meds?
    else
      event.assign_attributes(care_spot: subject, kind: subject.litter_box? ? :litter : :water, actions: [ params[:care_action].to_s ])
    end
    event
  end

  # A medication of this cat (or, for the owner, a one-off medicine by name).
  def assign_dose(event, pet)
    event.assign_attributes(dose_status: params[:dose_status], reason: params[:reason].presence)
    if params[:medication_id].present?
      event.medication = pet.medications.current.find(params[:medication_id])
      event.dose_time = params[:dose_time].presence
    else
      event.details = { medicine_name: params[:medicine_name], medicine_dose: params[:medicine_dose] }
    end
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
      "medication_id" => event.medication_id, "dose_time" => event.dose_time, "dose_status" => event.dose_status, "reason" => event.reason,
      "medicine_name" => event.details["medicine_name"], "medicine_dose" => event.details["medicine_dose"], "repeat_id" => repeat.id }
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
    changes[:details] = details_params if params.key?(:details)
    # Litter observations: "which cat", checked against the box's household by the model.
    changes[:pet_id] = params[:pet_id].presence if @event.litter? && params.key?(:pet_id)
    changes[:value] = params[:value] if params.key?(:value)
    changes[:note] = params[:note].to_s.first(200) if params.key?(:note)
    if @event.meds?
      changes[:dose_status] = params[:dose_status] if params.key?(:dose_status)
      changes[:reason] = params[:reason].presence if params.key?(:reason)
    end
    changes
  end

  def details_params
    details = params.fetch(:details, {})
    @event.litter? ? details.permit(*CareEvent::LITTER_DETAILS - [ "unusual" ], unusual: []).to_h : details.permit(*CareEvent::FED_DETAILS).to_h
  end

  def refuse
    redirect_to today_path, alert: t("care_events.not_allowed")
  end
end
