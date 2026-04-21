module TrackersHelper
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
      tracker.pet.trackers.select(:id, :brand, :description, :pet_id, :date, :feed_time).order(:date, :feed_time, :id).to_a.group_by do |t|
        [ t.brand.to_s.downcase.strip, normalize_description(t.description) ]
      end.map { |_, group| group.first.id }
    end
    @first_occurrence_ids[tracker.pet_id].include?(tracker.id)
  end

  def normalize_description(desc)
    # Ignore x2, x3, etc. at the end of the description and normalize parentheses
    desc.to_s.gsub("（", "(").gsub("）", ")").gsub(/\s*[xX]\d+\z/, "").squish.downcase
  end
end
