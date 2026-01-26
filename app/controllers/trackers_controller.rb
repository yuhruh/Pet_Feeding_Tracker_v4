class TrackersController < ApplicationController
  # include TrackersCalculable
  before_action :set_pet
  before_action :set_tracker, only: %i[ show edit update destroy ]
  before_action :require_authentication
  before_action :set_current_date, :set_current_time

  def import
    file = params[:file]
    return redirect_to pet_trackers_path, alert: "Only CSV please" unless file.content_type == "text/csv"

    CsvImportTrackersService.new(@pet).call(file)

    redirect_to pet_trackers_path, notice: "#{@pet.petname.capitalize}'s trackers imported!"
  end

  # GET /trackers or /trackers.json
  def index
    # @trackers = Tracker.all
    @trackers = @pet.trackers
    @trackers = @trackers.order(date: :asc, feed_time: :asc)

    respond_to do |format|
      format.html
      format.csv do
        send_data Tracker.to_csv, filename: "#{@pet.petname.capitalize}-trackers-#{Date.today}.csv", type: "text/csv"
      end
    end

    @dry_properties = @trackers.where(food_type: "Dry").where.not(total_ate_amount: nil).group(:date).order(:date).sum(:total_ate_amount).transform_keys { |key| key.strftime("%b %d") }.transform_values(&:to_f)
    @wet_properties = @trackers.where(food_type: "Wet").where.not(total_ate_amount: nil).group(:date).order(:date).sum(:total_ate_amount).transform_keys { |key| key.strftime("%b %d") }.transform_values(&:to_f)

    # Using average for weight is safer than sum, in case multiple entries exist for one day.
    @weight = @trackers.where.not(weight: nil).group(:date).order(:date).average(:weight).transform_keys { |key| key.strftime("%b %d") }.transform_values(&:to_f)
    # weights_by_date = @trackers.where.not(weight: nil).group(:date).average(:weight)
    # @weight = weights_by_date.sort_by { |date, _weight| date }.map { |date, weight| [date.strftime("%b %d"), weight.to_f] }

    @data = [
      { name: "Wet Food (g)", data: @wet_properties },
      { name: "Dry Food (g)", data: @dry_properties },
      { name: "Weight (kg)", data: @weight, type: "line" }
    ]
  end

  # GET /trackers/1 or /trackers/1.json
  def show
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
        format.html { redirect_to pet_trackers_path, notice: "Tracker was successfully created." }
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
      @tracker.result = [ @tracker.hungry[0], @tracker.love[0] ].join(" - ")
      @tracker.favorite_score = calculate_favorite([ @tracker.hungry[0], @tracker.love[0] ])
    end

    respond_to do |format|
      if @tracker.save
        format.html { redirect_to [ @pet, :trackers ], notice: "Tracker was successfully updated.", status: :see_other }
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
      format.html { redirect_to [ @pet, :trackers ], notice: "Tracker was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def favorite_food
    @favorite_foods = @pet.trackers.order(favorite_score: :desc)
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
        flash[:alert] = "Tracker not found."
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
      love_score = love[arr[1].to_sym]
      left_amount_score = @tracker.left_amount < (@tracker.amount)/4 ? 15 : 8
      frequent_score = @tracker.frequency * 2

      hungry_score.to_i + love_score.to_i + left_amount_score + frequent_score
    end
end
