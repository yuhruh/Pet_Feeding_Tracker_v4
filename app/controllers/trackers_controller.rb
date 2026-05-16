class TrackersController < ApplicationController
  include TrackersCalculable
  before_action :set_pet
  before_action :set_tracker, only: %i[ show edit update destroy ]
  before_action :require_authentication
  before_action :set_current_date, :set_current_time

  def import
    file = params[:file]
    if file.blank? || file.content_type != "text/csv"
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
    # Use the shared calculation logic from TrackersCalculable concern
    result = calculate_tracker_data(@pet, params, Current.user)

    @all_trackers = result[:all_trackers]
    @data = result[:chart_data]
    @chart_interval = result[:chart_interval]
    @min_weight = result[:min_weight]
    @max_weight = result[:max_weight]
    @min_date = result[:min_date]
    @max_date = result[:max_date]
    @dry_properties = result[:dry_properties]
    @wet_properties = result[:wet_properties]

    page = params[:page].blank? ? 1 : params[:page]
    session[:per_page] = params[:per_page] if params[:per_page].present?
    per_page = session[:per_page] || 10
    adapter_type = Rails.configuration.database_configuration[Rails.env]["adapter"]
    order_sql = if adapter_type == "sqlite3"
      "CASE WHEN come_back_to_eat = '' OR left_amount IS NULL THEN 0 ELSE 1 END ASC, date DESC, feed_time DESC"
    else
      "CASE WHEN come_back_to_eat = '' OR left_amount IS NULL THEN 0 ELSE 1 END ASC, date DESC, feed_time DESC, (feed_time AT TIME ZONE 'UTC' AT TIME ZONE '#{Current.user.timezone}') DESC"
    end
    @trackers = @all_trackers.reorder(Arel.sql(order_sql)).paginate(page: page, per_page: per_page)

    respond_to do |format|
      format.html
      format.csv do
        # Sort in Ruby using local time strings to avoid UTC-offset ordering issues
        # Use safe navigation or default value for strftime to prevent nil error
        timezone = Current.user.timezone
        sorted_trackers = @all_trackers.to_a.sort_by { |t| [ t.date, t.feed_time&.in_time_zone(timezone)&.strftime("%H:%M") || "00:00" ] }
        send_data Tracker.to_csv(sorted_trackers, timezone), filename: "#{@pet.petname.capitalize}-trackers-#{Date.today}.csv", type: "text/csv"
      end
    end
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
    if @tracker.left_amount.blank?
      @tracker.total_ate_amount = nil
    else
      @tracker.total_ate_amount = @tracker.amount.to_f - @tracker.left_amount.to_f
    end
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
      trackers = trackers.where(trackers_table[:food_type].matches("%#{params[:food_type].strip}%"))
    end

    @favorite_foods = trackers.group_by do |tracker|
      clean_description = tracker.description.to_s.gsub("（", "(").gsub("）", ")").gsub(/\s*[\(\s]*[xX×]\s*\d+[\)\s]*\z/, "").squish.downcase

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

    all_favorite_foods = @favorite_foods.sort_by { |f| f[:results].first[:favorite_score] }.reverse

    require "will_paginate/array"
    session[:per_page] = params[:per_page] if params[:per_page].present?
    per_page = session[:per_page] || 10
    @favorite_foods = all_favorite_foods.paginate(page: params[:page], per_page: per_page)


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
      format.json do
       render json: all_favorite_foods
      end
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
