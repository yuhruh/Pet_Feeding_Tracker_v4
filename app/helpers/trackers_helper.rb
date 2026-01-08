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
    classes = ["border-b"]
    if tracker.total_ate_amount.blank?
      classes << "bg-red-100"
    elsif tracker.come_back_to_eat.blank?
      classes << "bg-yellow-200"
    end
    classes.join(" ")
  end
end
