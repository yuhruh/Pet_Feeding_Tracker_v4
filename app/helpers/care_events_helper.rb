module CareEventsHelper
  KIND_ICONS = { "fed" => "🍽", "weight" => "⚖️", "litter" => "🚽", "water" => "💧", "meds" => "💊" }.freeze

  # "Litter box" in the reader's language, unless the owner named it.
  def care_spot_name(spot)
    spot.name.presence || t("care_spots.kinds.#{spot.kind}")
  end

  # The button label for one of a spot's jobs: "🧽 Fountain cleaned".
  def care_action_label(spot, action)
    # A fountain turned into a bowl keeps its past "filter changed" records.
    t("care_events.actions.#{spot.kind}.#{action}", default: t("care_events.actions.water_fountain.#{action}"))
  end

  # The same job in a sentence: "fountain cleaned".
  def care_action_done(spot, action)
    t("care_events.done.#{spot.kind}.#{action}", default: t("care_events.done.water_fountain.#{action}"))
  end

  def care_time(time, zone)
    time.in_time_zone(zone).strftime("%H:%M")
  end

  # "07:30" today, "yesterday 07:30", or "9/28 07:30".
  def care_when(time, day)
    local = time.in_time_zone(day.zone)
    clock = local.strftime("%H:%M")
    if local.to_date == day.date then clock
    elsif local.to_date == day.date - 1 then t("care_events.yesterday", time: clock)
    else "#{local.month}/#{local.day} #{clock}"
    end
  end

  def care_person(user)
    user ? user.username.split(" ").map(&:capitalize).join(" ") : t("care_events.someone")
  end

  def pet_display_name(pet)
    pet.petname.split(" ").map(&:capitalize).join(" ")
  end

  # "Aji: fed" / "Kitchen fountain: refilled, fountain cleaned" / "Aji: 4.2 kg"
  def care_event_summary(event)
    case event.kind
    when "fed" then t("care_events.summary.fed", pet: pet_display_name(event.pet))
    when "weight" then t("care_events.summary.weight", pet: pet_display_name(event.pet), kg: format("%g", event.value))
    when "meds" then t("care_events.summary.meds", pet: pet_display_name(event.pet), medicine: dose_name(event), outcome: dose_outcome(event))
    else "#{care_spot_name(event.care_spot)}: #{event.actions.map { |action| care_action_done(event.care_spot, action) }.join(t('support.array.words_connector'))}"
    end
  end

  # "Clavamox 1 tablet (20:00)"
  def dose_name(event)
    [ event.medicine_label, ("(#{event.dose_time})" if event.dose_time) ].compact.join(" ")
  end

  # "given" / "couldn't give (spat out)"
  def dose_outcome(event)
    if event.given? then t("care_events.dose.given")
    else t("care_events.dose.couldnt_give_because", reason: t("care_events.reasons.#{event.reason}"))
    end
  end

  # One dose on a cat's line: "08:00 given by Mom", "20:00 due", "08:00 overdue".
  def dose_status_text(dose, zone)
    status = dose.status
    case status
    when "given" then t("care_events.dose.given_by", time: dose.time, person: care_person(dose.event.actor), at: care_time(dose.event.occurred_at, zone))
    when "couldnt_give" then "#{dose.time} #{dose_outcome(dose.event)}"
    else t("care_events.dose.#{status}", time: dose.time)
    end
  end

  DOSE_CLASSES = { "given" => "text-emerald-700", "couldnt_give" => "text-amber-700", "overdue" => "text-red-600 font-semibold", "due" => "text-gray-600" }.freeze

  # "🧽 Fountain cleaned due today", "... in 3 days", "... 2 days overdue".
  def routine_due_text(routine, due_in)
    job = care_action_label(routine.care_spot, routine.action)
    if due_in.negative? then t("care_routines.due.overdue", job: job, count: -due_in)
    elsif due_in.zero? then t("care_routines.due.today", job: job)
    else t("care_routines.due.in_days", job: job, count: due_in)
    end
  end

  SLOT_CLASSES = { "done" => "text-emerald-700", "due" => "text-gray-600", "late" => "text-red-600 font-semibold" }.freeze

  # One set time: "08:00 ✓ 07:55 by Mom", "20:00 due", "20:00 not done" (checkpoint H2).
  def routine_slot_text(slot, status, zone)
    if status == "done"
      t("care_routines.slot.done", time: slot.time, at: care_time(slot.event.occurred_at, zone), person: care_person(slot.event.actor))
    else
      t("care_routines.slot.#{status}", time: slot.time)
    end
  end

  # "🚽 Scooped due at 20:00", "... due tomorrow at 03:00", "... overdue since 20:00" (checkpoint H2).
  def routine_due_at_text(job, due_at, day)
    local = due_at.in_time_zone(day.zone)
    return t("care_routines.due.overdue_since", job: job, when: care_when(due_at, day)) if due_at <= Time.current

    if local.to_date == day.date then t("care_routines.due.at", job: job, time: local.strftime("%H:%M"))
    elsif local.to_date == day.date + 1 then t("care_routines.due.tomorrow_at", job: job, time: local.strftime("%H:%M"))
    else t("care_routines.due.on", job: job, when: "#{local.month}/#{local.day} #{local.strftime('%H:%M')}")
    end
  end

  # "Delete “Aji: fed” at 08:12? ..." (checkpoint H3), with a word about a linked tracker.
  def care_delete_confirm(event, zone)
    text = t("care_events.delete.confirm", what: care_event_summary(event), time: care_time(event.occurred_at, zone))
    event.tracker_id ? "#{text} #{t('care_events.delete.tracker_stays', pet: pet_display_name(event.pet))}" : text
  end

  # "Aji · pee normal · 2 poops · stool soft · blood", only what was observed.
  def litter_observations_text(event, with_cat: true)
    details = event.details
    [
      (pet_display_name(event.pet) if with_cat && event.pet),
      (t("care_events.observations.pee_text", value: t("care_events.observations.pee_values.#{details['pee']}")) if details["pee"]),
      (t("care_events.observations.poops_text", count: details["poop_count"].to_i) if details.key?("poop_count")),
      (t("care_events.observations.stool_text", value: t("care_events.observations.stool_values.#{details['stool']}")) if details["stool"]),
      *Array(details["unusual"]).map { |value| t("care_events.observations.unusual_values.#{value}") }
    ].compact.join(" · ")
  end

  # "曙光 無穀滋養鴨肉 · 40 g"
  def fed_details_text(brand, description, amount)
    [ [ brand, description ].compact_blank.join(" ").presence, (t("care_events.grams", amount: format("%g", amount.to_f)) if amount.present?) ].compact.join(" · ")
  end
end
