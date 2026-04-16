module TrackersCalculable
  extend ActiveSupport::Concern

  def calculate_tracker_data(pet, params, user)
    all_trackers = pet.trackers
    trackers_table = Tracker.arel_table

    min_date = pet.trackers.minimum(:date)
    max_date = pet.trackers.maximum(:date)

    if params[:range] == "custom" && params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      all_trackers = all_trackers.where(date: start_date..end_date)
    else
      case params[:range]
      when "7"
        all_trackers = all_trackers.where("date >= ?", 7.days.ago.to_date)
      when "30"
        all_trackers = all_trackers.where("date >= ?", 30.days.ago.to_date)
      when "120"
        all_trackers = all_trackers.where("date >= ?", 120.days.ago.to_date)
      when "180"
        all_trackers = all_trackers.where("date >= ?", 180.days.ago.to_date)
      when "YTD"
        all_trackers = all_trackers.where("date >= ?", Date.today.beginning_of_year)
      end
    end

    # Apply filters
    all_trackers = all_trackers.where(trackers_table[:food_type].matches("%#{params[:food_type].strip}%")) if params[:food_type].present?
    all_trackers = all_trackers.where(trackers_table[:brand].matches("%#{params[:brand].strip}%")) if params[:brand].present?
    all_trackers = all_trackers.where(trackers_table[:description].matches("%#{params[:description].strip}%")) if params[:description].present?
    all_trackers = all_trackers.where(trackers_table[:note].matches("%#{params[:note].strip}%")) if params[:note].present?

    hotel_keywords = [ "hotel", "旅館", "貓旅", "boarding", "resort" ]
    formatted_keywords = hotel_keywords.map { |k| "%#{k}%" }
    hotel_conditions = formatted_keywords.map { |keyword| trackers_table[:note].matches(keyword) }.reduce(:or)
    normal_conditions = trackers_table[:note].eq(nil).or(hotel_conditions.not)

    dry_raw = all_trackers.where(food_type: [ "Kibble", "Freeze-Dried" ]).where(normal_conditions).where.not(total_ate_amount: nil).group(:date).sum(:total_ate_amount)
    dry_hotel_raw = all_trackers.where(food_type: [ "Kibble", "Freeze-Dried" ]).where(hotel_conditions).where.not(total_ate_amount: nil).group(:date).sum(:total_ate_amount)
    wet_raw = all_trackers.where(food_type: "Wet").where(normal_conditions).where.not(total_ate_amount: nil).group(:date).sum(:total_ate_amount)
    wet_hotel_raw = all_trackers.where(food_type: "Wet").where(hotel_conditions).where.not(total_ate_amount: nil).group(:date).sum(:total_ate_amount)

    all_dates = (dry_raw.keys + dry_hotel_raw.keys + wet_raw.keys + wet_hotel_raw.keys).uniq.sort
    data_points_count = all_dates.size

    chart_interval = case data_points_count
    when 0..30 then 1
    when 31..60 then 2
    when 61..120 then 3
    else 6
    end

    format_chart_data = ->(hash, dates) {
      dates.map { |date| [ date.strftime("%y/%m/%d"), hash[date].to_f ] }.to_h
    }

    weight_data = all_trackers.where.not(weight: nil).group(:date).order(:date).average(:weight).transform_keys { |key| key.strftime("%y/%m/%d") }.transform_values(&:to_f)
    weight_values = weight_data.values
    if weight_values.present?
      min_val = weight_values.min
      max_val = weight_values.max
      min_weight = [ 0, (min_val - 2) ].max.floor
      max_weight = (max_val + 2).ceil
    else
      min_weight = 0
      max_weight = 15
    end

    chart_data = [
      { name: I18n.t("trackers.chart.wet_food"), data: format_chart_data.call(wet_raw, all_dates) },
      { name: "Wet (Hotel)", data: format_chart_data.call(wet_hotel_raw, all_dates) },
      { name: I18n.t("trackers.chart.dry_food"), data: format_chart_data.call(dry_raw, all_dates) },
      { name: "Dry (Hotel)", data: format_chart_data.call(dry_hotel_raw, all_dates) },
      { name: I18n.t("trackers.chart.weight"), data: weight_data, type: "line" }
    ]

    {
      all_trackers: all_trackers,
      chart_data: chart_data,
      chart_interval: chart_interval,
      min_weight: min_weight,
      max_weight: max_weight,
      min_date: min_date,
      max_date: max_date,
      dry_properties: format_chart_data.call(dry_raw, all_dates),
      wet_properties: format_chart_data.call(wet_raw, all_dates)
    }
  end
end
