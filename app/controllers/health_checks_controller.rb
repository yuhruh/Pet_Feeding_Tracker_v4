class HealthChecksController < ApplicationController
  before_action :set_pet
  before_action :set_health_check, only: %i[ show edit update destroy ]
  before_action :require_authentication
  before_action :set_current_date


  # GET /health_checks or /health_checks.json
  def index
    # @health_checks = HealthCheck.all
    health_checks = @pet.health_checks
    adapter_type = Rails.configuration.database_configuration[Rails.env]["adapter"]
    order_sql = if adapter_type == "sqlite3"
      "exam_date DESC"
    else
      "exam_date DESC"
    end
    @health_checks = health_checks.order(order_sql)
  end

  # GET /health_checks/1 or /health_checks/1.json
  def show
    @health_checks = @pet.health_checks
  end

  # GET /health_checks/new
  def new
    # @health_check = HealthCheck.new
    @health_check = @pet.health_checks.build
  end

  # GET /health_checks/1/edit
  def edit
  end

  # POST /health_checks or /health_checks.json
  def create
    # @health_check = HealthCheck.new(health_check_params)
    @health_check = @pet.health_checks.build(health_check_params)

    respond_to do |format|
      if @health_check.save
        format.html { redirect_to pet_health_checks_path(@pet), notice: "Health check was successfully created." }
        format.json { render :show, status: :created, location: pet_health_checks_path(@pet) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @health_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /health_checks/1 or /health_checks/1.json
  def update
    @health_check.assign_attributes(health_check_params)
    respond_to do |format|
      if @health_check.update(health_check_params)
        format.html { redirect_to pet_health_check_path(@pet, @health_check), notice: "Health check was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: pet_health_check_path(@pet, @health_check) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @health_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /health_checks/1 or /health_checks/1.json
  def destroy
    @health_check.destroy!

    respond_to do |format|
      format.html { redirect_to pet_health_checks_url(@pet), notice: "Health check was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def bulk_delete
    @pet.health_checks.where(id: params[:health_check_ids]).destroy_all
    respond_to do |format|
      format.html { redirect_to pet_health_checks_path(@pet), notice: "Selected health checks were successfully deleted." }
      format.json { head :no_content }
    end
  end

  def liver
    health_checks = @pet.health_checks
    adapter_type = Rails.configuration.database_configuration[Rails.env]["adapter"]
    order_sql = if adapter_type == "sqlite3"
      "exam_date DESC"
    else
      "exam_date DESC"
    end
    # ranges = {
    #   glu: [74, 159],
    #   tp: [5.7, 8.9],
    #   alb: [2.2, 4.0],
    #   alt: [12, 130],
    #   alkp: [14, 111],
    #   bun: [16, 36]
    # }
    @health_checks = health_checks.order(order_sql)
    @glu_checks = @health_checks.where.not(glu: nil).order(:exam_date)
    # @glu_properties = @health_checks.where.not(glu: nil).group(:exam_date).order(:exam_date).average(:glu).transform_keys { |date| date.strftime("%Y-%m-%d") }.transform_values(&:to_f)
    # @glu_chart_data = @glu_properties.map { |year, avg| [year, avg, *ranges[:glu]] }
    glu_low_val = 74
    glu_high_val = 159

    glu_reading_data = @glu_checks.map { |health_check| [ health_check.exam_date.to_s, health_check.glu.to_f ] }
    glu_low_val = @glu_checks.map { |health_check| [ health_check.exam_date.to_s, glu_low_val ] }
    glu_high_val = @glu_checks.map { |health_check| [ health_check.exam_date.to_s, glu_high_val ] }


    @glu_chart_data = [
      { name: "GLU(mg/dL)", data: glu_reading_data },
      { name: "Lower Limit (74)", data: glu_low_val },
      { name: "Upper Limit (159)", data: glu_high_val }
    ]


    @tp_properties = @health_checks.where.not(tp: nil).group(:exam_date).order(:exam_date).average(:tp).transform_keys { |date| date.strftime("%Y") }.transform_values(&:to_f)
    @alb_properties = @health_checks.where.not(alb: nil).group(:exam_date).order(:exam_date).average(:alb).transform_keys { |date| date.strftime("%Y") }.transform_values(&:to_f)
    @alt_properties = @health_checks.where.not(alt: nil).group(:exam_date).order(:exam_date).average(:alt).transform_keys { |date| date.strftime("%Y") }.transform_values(&:to_f)
    @alkp_properties = @health_checks.where.not(alkp: nil).group(:exam_date).order(:exam_date).average(:alkp).transform_keys { |date| date.strftime("%Y") }.transform_values(&:to_f)
    @bun_properties = @health_checks.where.not(bun: nil).group(:exam_date).order(:exam_date).average(:bun).transform_keys { |date| date.strftime("%Y") }.transform_values(&:to_f)
  end

  private
    def set_pet
      @pet = Pet.find(params[:pet_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_health_check
      @health_check = @pet.health_checks.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "Health check not found."
        redirect_to pet_health_checks_url
      # @health_check = HealthCheck.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def health_check_params
      params.require(:health_check).permit(:exam_date, :crea, :bun, :phos, :ca, :alb, :chol, :tp, :alt, :alkp, :ggt, :glu, :tbil, :amyl, :lipa, :na, :k, :cl, :rbc, :hct, :hgb, :mcv, :mch, :mchc, :rdw, :retic, :retic_hgb, :wbc, :neu, :lym, :mono, :eos, :baso, :plt, :mpv, :pct, :osm_cal, :pet_id)
    end

    def set_current_date
      Time.zone = Current.user.timezone
      Date.current.strftime("%Y-%m-%d")
    end
end
