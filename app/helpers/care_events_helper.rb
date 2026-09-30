module CareEventsHelper
  KIND_ICONS = { "fed" => "🍽", "weight" => "⚖️", "litter" => "🚽", "water" => "💧" }.freeze

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
    else "#{care_spot_name(event.care_spot)}: #{event.actions.map { |action| care_action_done(event.care_spot, action) }.join(t('support.array.words_connector'))}"
    end
  end

  # "曙光 無穀滋養鴨肉 · 40 g"
  def fed_details_text(brand, description, amount)
    [ [ brand, description ].compact_blank.join(" ").presence, (t("care_events.grams", amount: format("%g", amount.to_f)) if amount.present?) ].compact.join(" · ")
  end
end
