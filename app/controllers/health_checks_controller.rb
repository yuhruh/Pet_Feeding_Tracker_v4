class HealthChecksController < ApplicationController
  before_action :set_pet
  before_action :set_health_check, only: %i[ show edit update destroy ]
  before_action :require_authentication


  # GET /health_checks or /health_checks.json
  def index
    # @health_checks = HealthCheck.all
    @health_checks = @pet.health_checks
  end

  # GET /health_checks/1 or /health_checks/1.json
  def show
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
        format.html { redirect_to pet_health_check_path(@pet, @health_check), notice: "Health check was successfully created." }
        format.json { render :show, status: :created, location: pet_health_check_path(@pet, @health_check) }
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
      params.require(:health_check).permit(:crea, :bun, :phos, :ca, :alb, :chol, :tp, :alt, :alkp, :ggt, :glu, :tbil, :amyl, :lipa, :na, :k, :cl, :rbc, :hct, :hgb, :mcv, :mch, :mchc, :rdw, :retic, :retic_hgb, :wbc, :neu, :lym, :mono, :eos, :baso, :plt, :mpv, :pct, "osm-cal", :pet_id)
    end
end
