class HealthChecksController < ApplicationController
  # Each extraction holds a server thread while Gemini reads the images.
  rate_limit to: 10, within: 1.minute, only: :extract_data, by: -> { Current.user&.id || request.remote_ip },
             with: -> { render json: { error: t("services.gemini_ocr.rate_limited") }, status: :too_many_requests }
  before_action :set_pet
  before_action :set_health_check, only: %i[ show edit update destroy ]
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

  def extract_data
    file_paths = Array(params[:files]).grep(ActionDispatch::Http::UploadedFile).map(&:path)
    # Too many, too large or not an image: reject before anything is sent to Gemini.
    if (upload_error = GeminiOcrService.upload_error(file_paths))
      render json: { error: upload_error }, status: :unprocessable_entity
    else
      render json: GeminiOcrService.new(file_paths, Current.user).call
    end
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
        format.html { redirect_to pet_health_checks_path(@pet), notice: t(".notice") }
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
        format.html { redirect_to pet_health_checks_path(@pet), notice: t(".notice"), status: :see_other }
        format.json { render :show, status: :ok, location: pet_health_checks_path(@pet) }
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
      format.html { redirect_to pet_health_checks_url(@pet), notice: t(".notice"), status: :see_other }
      format.json { head :no_content }
    end
  end

  def bulk_delete
    @pet.health_checks.where(id: params[:health_check_ids]).destroy_all
    respond_to do |format|
      format.html { redirect_to pet_health_checks_path(@pet), notice: t(".notice") }
      format.json { head :no_content }
    end
  end

  private
    # Only the signed-in user's own pets; anyone else's pet is treated as not found.
    def set_pet
      @pet = Current.user.pets.find(params[:pet_id])
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to pets_path, alert: t("pets.not_found") }
        format.any { head :not_found }
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_health_check
      @health_check = @pet.health_checks.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = t("health_checks.not_found")
        redirect_to pet_health_checks_url
      # @health_check = HealthCheck.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def health_check_params
      params.require(:health_check).permit(:exam_date, :crea, :bun, :phos, :ca, :alb, :chol, :tp, :alt, :alkp, :ggt, :glu, :tbil, :amyl, :lipa, :na, :k, :cl, :rbc, :hct, :hgb, :mcv, :mch, :mchc, :rdw, :retic, :retic_hgb, :wbc, :neu, :lym, :mono, :eos, :baso, :plt, :mpv, :pct, :osm_cal, :fbnp, :glob, :fpl2, :felv, :fiv)
    end

    def set_current_date
      Time.zone = Current.user.timezone
      Date.current.strftime("%Y-%m-%d")
    end
end
