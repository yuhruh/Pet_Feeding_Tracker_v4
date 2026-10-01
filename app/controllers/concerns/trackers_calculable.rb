module TrackersCalculable
  extend ActiveSupport::Concern

  # care: also the household's care records (⚖️ weights on the weight line and
  # the "Care by day" chart); not on the public share page.
  def calculate_tracker_data(pet, params, user, care: false)
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
        start_date = 7.days.ago.to_date
      when "30"
        start_date = 30.days.ago.to_date
      when "120"
        start_date = 120.days.ago.to_date
      when "180"
        start_date = 180.days.ago.to_date
      when "YTD"
        start_date = Date.today.beginning_of_year
      end
      all_trackers = all_trackers.where("date >= ?", start_date) if start_date
    end
    care_chart = CareChart.new(pet, from: start_date, to: end_date) if care && pet.household

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

    # Every tracker weight, plus the ⚖️ records, averaged per day.
    weight_points = all_trackers.where.not(weight: nil).pluck(:date, :weight).map { |date, kg| [ date, kg.to_f ] }
    weight_points += care_chart.weights if care_chart
    weight_by_date = weight_points.group_by(&:first).transform_values { |points| points.sum(&:last) / points.size }.sort.to_h

    # A day with only a weight still gets its place in date order.
    all_dates = (dry_raw.keys + dry_hotel_raw.keys + wet_raw.keys + wet_hotel_raw.keys + weight_by_date.keys).uniq.sort
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

    weight_data = weight_by_date.transform_keys { |key| key.strftime("%y/%m/%d") }
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
      wet_properties: format_chart_data.call(wet_raw, all_dates),
      care: care_chart
    }
  end
end
