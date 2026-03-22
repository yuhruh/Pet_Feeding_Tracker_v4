class TrackersController < ApplicationController
  # include TrackersCalculable
  before_action :set_pet
  before_action :set_tracker, only: %i[ show edit update destroy ]
  before_action :require_authentication
  before_action :set_current_date, :set_current_time

  def import
    file = params[:file]
    if file.nil? || file.content_type != "text/csv"
      return redirect_to pet_trackers_path(@pet, page: params[:page], per_page: params[:per_page]), alert: t(".import.alert")
    end

    importer = CsvImportTrackersService.new(@pet, Current.user)
    if importer.call(file)
      redirect_to pet_trackers_path(@pet, page: params[:page], per_page: params[:per_page]), notice: t(".import.notice", petname: @pet.petname.capitalize)
    else
      redirect_to pet_trackers_path(@pet, page: params[:page], per_page: params[:per_page]), alert: importer.errors.join(", ")
    end
  end

  # GET /trackers or /trackers.json
  def index
    # @trackers = Tracker.all
    @all_trackers = @pet.trackers
    trackers_table = Tracker.arel_table

    @min_date = @pet.trackers.minimum(:date)
    @max_date = @pet.trackers.maximum(:date)

    if params[:range] == "custom" && params[:start_date].present? && params[:end_date].present?
      @start_date = Date.parse(params[:start_date])
      @end_date = Date.parse(params[:end_date])

      if @start_date > @end_date
        flash.now[:alert] = t(".index.invalid_date_range")
      elsif @end_date < @min_date || @start_date > @max_date
        flash.now[:notice] = t(".index.no_data_in_range")
      end

      @all_trackers = @all_trackers.where(date: @start_date..@end_date)
    else
      # Default filtering logic
      case params[:range]
      when "7"
        @all_trackers = @all_trackers.where("date >= ?", 7.days.ago.to_date)
      when "30"
        @all_trackers = @all_trackers.where("date >= ?", 30.days.ago.to_date)
      when "120"
        @all_trackers = @all_trackers.where("date >= ?", 120.days.ago.to_date)
      end
    end

    if params[:food_type].present?
      @all_trackers = @all_trackers.where(trackers_table[:food_type].matches("%#{params[:food_type]}%"))
    end

    if params[:brand].present?
      @all_trackers = @all_trackers.where(trackers_table[:brand].matches("%#{params[:brand]}%"))
    end

    if params[:description].present?
      @all_trackers = @all_trackers.where(trackers_table[:description].matches("%#{params[:description]}%"))
    end

    if params[:note].present?
      @all_trackers = @all_trackers.where(trackers_table[:note].matches("%#{params[:note]}%"))
    end

    page = params[:page].blank? ? 1 : params[:page]
    session[:per_page] = params[:per_page] if params[:per_page].present?
    per_page = session[:per_page] || 10
    adapter_type = Rails.configuration.database_configuration[Rails.env]["adapter"]
    order_sql = if adapter_type == "sqlite3"
      "date DESC, feed_time DESC"
    else
      "date DESC, (feed_time AT TIME ZONE 'UTC' AT TIME ZONE '#{Current.user.timezone}') DESC"
    end
    @trackers = @all_trackers.reorder(Arel.sql(order_sql)).paginate(page: page, per_page: per_page)

    respond_to do |format|
      format.html
      format.csv do
        send_data @all_trackers.reorder(Arel.sql(order_sql)).to_csv, filename: "#{@pet.petname.capitalize}-trackers-#{Date.today}.csv", type: "text/csv"
      end
    end

    hotel_keywords = [ "hotel", "旅館", "貓旅", "boarding", "resort" ]

    # Sanitize hotel keywords for LIKE query
    formatted_keywords = hotel_keywords.map { |k| "%#{k}%" }

    # Use Arel to safely construct the query for hotel stays
    hotel_conditions = formatted_keywords.map do |keyword|
      trackers_table[:note].matches(keyword)
    end.reduce(:or)

    # Use Arel to safely construct the query for normal stays (not in a hotel)
    normal_conditions = trackers_table[:note].eq(nil).or(hotel_conditions.not)

    dry_raw = @all_trackers.where(food_type: [ "Kibble", "Freeze-Dried" ]).where(normal_conditions).where.not(total_ate_amount: nil).group(:date).sum(:total_ate_amount)
    dry_hotel_raw = @all_trackers.where(food_type: [ "Kibble", "Freeze-Dried" ]).where(hotel_conditions).where.not(total_ate_amount: nil).group(:date).sum(:total_ate_amount)
    wet_raw = @all_trackers.where(food_type: "Wet").where(normal_conditions).where.not(total_ate_amount: nil).group(:date).sum(:total_ate_amount)
    wet_hotel_raw = @all_trackers.where(food_type: "Wet").where(hotel_conditions).where.not(total_ate_amount: nil).group(:date).sum(:total_ate_amount)

    all_dates = (dry_raw.keys + dry_hotel_raw.keys + wet_raw.keys + wet_hotel_raw.keys).uniq.sort

     data_points_count = all_dates.size

     @chart_interval = case data_points_count
     when 0..30 then 1
     when 31..60 then 2
     when 61..120 then 3
     else 6
     end


    format_chart_data = ->(hash, all_dates) {
      data = all_dates.map { |date| [ date.strftime("%y/%m/%d"), hash[date].to_f ] }
      data.to_h
    }

    @dry_properties = format_chart_data.call(dry_raw, all_dates)
    @dry_hotel_properties = format_chart_data.call(dry_hotel_raw, all_dates)
    @wet_properties = format_chart_data.call(wet_raw, all_dates)
    @wet_hotel_properties = format_chart_data.call(wet_hotel_raw, all_dates)
    # Using average for weight is safer than sum, in case multiple entries exist for one day.
    @weight = @all_trackers.where.not(weight: nil).group(:date).order(:date).average(:weight).transform_keys { |key| key.strftime("%y/%m/%d") }.transform_values(&:to_f)

    # @total_ate_quantity = @all_trackers.where.not(total_ate_amount: nil).group(:date).sum(:total_ate_amount).transform_keys { |key| key.strftime("%y/%m/%d") }.transform_values(&:to_f)

    weight_values = @weight.values
    if weight_values.present?
      min_val = weight_values.min
      max_val = weight_values.max
      @min_weight = [ 0, (min_val - 2) ].max.floor
      @max_weight = (max_val + 2).ceil
    else
      @min_weight = 0
      @max_weight = 15 # A default value
    end

    # total_ate_quantity_values = @total_ate_quantity.values
    # if total_ate_quantity_values.present?
    #   min_val = total_ate_quantity_values.min
    #   max_val = total_ate_quantity_values.max
    #   @min_total_ate = [ 0, (min_val - 10) ].max.floor
    #   @max_total_ate = (max_val + 10).ceil
    # else
    #   @min_total_ate = 0
    #   @max_total_ate = 100 # A default value
    # end

    @data = [
      { name: t(".chart.wet_food"), data: @wet_properties },
      { name: "Wet (Hotel)", data: @wet_hotel_properties },
      { name: t(".chart.dry_food"), data: @dry_properties },
      { name: "Dry (Hotel)", data: @dry_hotel_properties },
      { name: t(".chart.weight"), data: @weight, type: "line" }
    ]
  end

  # GET /trackers/1 or /trackers/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @tracker }
    end
  end

  # GET /trackers/new
  def new
    # @tracker = Tracker.new
    @tracker = @pet.trackers.build
  end

  # GET /trackers/1/edit
  def edit
  end

  # POST /trackers or /trackers.json
  def create
    # @tracker = Tracker.new(tracker_params)
    @tracker = @pet.trackers.build(tracker_params)
    @tracker.dry_food_id = nil if params[:tracker][:dry_food_id].blank?

    respond_to do |format|
      if @tracker.save
        format.html { redirect_to pet_trackers_path(@pet, page: params[:tracker][:page], per_page: session[:per_page]), notice: t(".create.notice") }
        format.json { render :show, status: :created, location: pet_trackers_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trackers/1 or /trackers/1.json
  def update
    # @tracker.update!(params.expect(tracker: [ :amount, :left_amount, :hungry, :come_back_to_eat, :love ]))
    @tracker.assign_attributes(tracker_params)
    @tracker.dry_food_id = nil if params[:tracker][:dry_food_id].blank?
    @tracker.total_ate_amount = @tracker.amount.to_f - @tracker.left_amount.to_f
    @tracker.frequency = calculate_frequency(@tracker.come_back_to_eat)
    if @tracker.hungry.present? && @tracker.love.present?
      result_parts = [ Tracker.hungries[@tracker.hungry.to_sym][0], @tracker.love[0] ]
      @tracker.result = result_parts.join(" - ")
      @tracker.favorite_score = calculate_favorite(result_parts)
    else
      @tracker.result = nil
      @tracker.favorite_score = 0
    end

    respond_to do |format|
      if @tracker.save
        format.html { redirect_to pet_trackers_path(@pet, page: params[:tracker][:page], per_page: session[:per_page]), notice: t(".update.notice"), status: :see_other }
        format.json { render :show, status: :ok, location: [ @pet, :trackers ] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trackers/1 or /trackers/1.json
  def destroy
    @tracker.destroy!

    respond_to do |format|
      format.html { redirect_to pet_trackers_path(@pet, page: params[:page], per_page: session[:per_page]), notice: t(".destroy.notice"), status: :see_other }
      format.json { head :no_content }
    end
  end

  def favorite_food
    trackers = @pet.trackers.where.not(hungry: [ nil, "" ], love: [ nil, "" ]).order(date: :desc)

    if params[:food_type].present?
      trackers_table = Tracker.arel_table
      trackers = trackers.where(trackers_table[:food_type].matches("%#{params[:food_type]}%"))
    end

    @favorite_foods = trackers.group_by do |tracker|
      clean_description = tracker.description.to_s.gsub("（", "(").gsub("）", ")").gsub(/\s*[xX]\d+\z/, "").squish.downcase

      [ tracker.food_type.to_s.squish.downcase, tracker.brand.to_s.squish.downcase, clean_description ]
    end.map do |(food_type, brand, description), group_trackers|
      unique_daily_results = group_trackers.sort_by { |t| t.favorite_score }.reverse
                                          .uniq { |t| t.date }
      {
        food_type: food_type,
        brand: brand,
        description: description,
        count: group_trackers.size,
        results: unique_daily_results.first(5).sort_by { |t| t.date }.reverse.map do |t|
          {
            id: t.id,
            date: t.date.strftime("%Y/%m/%d"),
            result: t.result,
            favorite_score: t.favorite_score
          }
        end
      }
    end

    require "will_paginate/array"
    session[:per_page] = params[:per_page] if params[:per_page].present?
    per_page = session[:per_page] || 10
    @favorite_foods = @favorite_foods.sort_by { |f| f[:results].first[:favorite_score] }.reverse.paginate(page: params[:page], per_page: per_page)


    # trackers = trackers.order(favorite_score: :desc)

    # unique_foods = trackers.each_with_object({}) do |tracker, hash|
    #   normalized_description = tracker.description.to_s.gsub(/\s*[xX]\d+\z/, "").strip
    #   key = [ tracker.brand, normalized_description ]
    #   hash[key] ||= tracker
    # end.values

    # require "will_paginate/array"
    # @favorite_foods = unique_foods.paginate(page: params[:page], per_page: params[:per_page] || 10)

    respond_to do |format|
      format.html
      format.json { render json: @favorite_foods }
    end
  end

  def bulk_delete
    @pet.trackers.where(id: params[:tracker_ids]).destroy_all
    respond_to do |format|
      format.html { redirect_to pet_trackers_path(@pet, page: params[:page], per_page: params[:per_page]), notice: t(".bulk_delete.notice") }
      format.json { head :no_content }
    end
  end

  private
    def set_pet
      @pet = Pet.find(params[:pet_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_tracker
      # @tracker = Tracker.find(params.expect(:id))
      @tracker = @pet.trackers.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = t(".set_tracker.alert")
        redirect_to pet_tracker_path
    end

    def set_current_time
      Time.zone = Current.user.timezone
      Time.current.strftime("%H:%M")
    end

    def set_current_date
      Time.zone = Current.user.timezone
      Date.current.strftime("%Y-%m-%d")
    end

    # Only allow a list of trusted parameters through.
    def tracker_params
      params.expect(tracker: [ :date, :feed_time, :come_back_to_eat, :food_type, :brand, :description, :hungry, :amount, :left_amount, :love, :total_ate_amount, :frequency, :result, :favorite_score, :note, :weight, :pet_id, :dry_food_id ])
    end

    def calculate_frequency(time_string)
      time_string == "-" ? 0 : time_string.split(", ").count
    end

    def calculate_favorite(arr)
      hungry = { "💖": 10, "🔺": 5, "❌": 0 }
      love = { "💕": 15,  "🔺": 5, "❌": 0 }

      hungry_score = hungry[arr[0].to_sym]
      love_score = arr[1] ? love[arr[1].to_sym] : 0
      left_amount = @tracker.left_amount || 0
      left_amount_score = left_amount < (@tracker.amount) / 4 ? 15 : 8
      frequent_score = @tracker.frequency * 2

      hungry_score.to_i + love_score.to_i + left_amount_score + frequent_score
    end
end
