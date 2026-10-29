module TrackersHelper
  # The search, chart range and per-page controls are separate GET forms, so each
  # sends only its own fields. Hidden copies of the others' current values keep
  # one form from wiping out what the others set.
  def hidden_list_params(form, *keys)
    safe_join(keys.filter_map do |key|
      value = key == :per_page ? current_per_page : params[key]
      form.hidden_field(key, value: value, id: nil) if value.present?
    end)
  end

  # The controller remembers the chosen per page in the session.
  def current_per_page
    (params[:per_page].presence || session[:per_page] || 10).to_i
  end

  # The search keywords and chart range now applied to the list, for exporting
  # only those records. "All time" isn't a filter.
  def tracker_filter_params
    filters = params.slice(:food_type, :brand, :description, :note, :range, :start_date, :end_date).permit(:food_type, :brand, :description, :note, :range, :start_date, :end_date).to_h.compact_blank
    filters.delete("range") if filters["range"] == "all"
    filters.except!("start_date", "end_date") unless filters["range"] == "custom"
    filters.symbolize_keys
  end

  def set_current_time
    Time.zone = Current.user.timezone
    Time.current.strftime("%H:%M")
  end

  def set_current_date
    Time.zone = Current.user.timezone
    Date.current.strftime("%Y-%m-%d")
  end

  def tracker_row_class(tracker)
    classes = []

    if first_occurrence?(tracker)
      classes << "text-orange-600"
    else
      classes << "text-sky-700"
    end

    if tracker.come_back_to_eat.blank?
      classes << "bg-yellow-100"
    elsif tracker.total_ate_amount.blank?
      classes << "bg-red-100"
    elsif tracker.result.blank? || tracker.hungry.blank?
      classes << "bg-blue-200"
    end
    classes.join(" ")
  end

  private

  def first_occurrence?(tracker)
    @first_occurrence_ids ||= {}
    @first_occurrence_ids[tracker.pet_id] ||= begin
      local_feed_time = Tracker.local_feed_time_sql(tracker.pet.timezone)
      tracker.pet.trackers.select(:id, :brand, :description, :pet_id, :date, :feed_time).order(Arel.sql("date ASC, #{local_feed_time} ASC, id ASC")).to_a.group_by do |t|
        [ t.brand.to_s.downcase.strip, normalize_description(t.description) ]
      end.map { |_, group| group.first.id }
    end
    @first_occurrence_ids[tracker.pet_id].include?(tracker.id)
  end

  def normalize_description(desc)
    # Ignore x2, x3, etc. (including the × symbol, spaces, and parentheses) at the end of the description
    desc.to_s.gsub("（", "(").gsub("）", ")").gsub(/\s*[\(\s]*[xX×]\s*\d+[\)\s]*\z/, "").squish.downcase
  end
end
