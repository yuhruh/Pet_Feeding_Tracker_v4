class DryFoodsController < ApplicationController
  before_action :set_dry_food, only: %i[ show destroy ]

  # GET /dry_foods or /dry_foods.json
  def index
    @dry_foods = Current.user.dry_foods
    respond_to do |format|
      format.html
      format.json { render json: @dry_foods }
    end
  end

  # GET /dry_foods/1 or /dry_foods/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @dry_food }
    end
  end

  # GET /dry_foods/new
  def new
    @dry_food = Current.user.dry_foods.build
  end

  # POST /dry_foods or /dry_foods.json
  def create
    @dry_food = Current.user.dry_foods.build(dry_food_params)

    respond_to do |format|
      if @dry_food.save
        format.html { redirect_to dry_foods_path, notice: "Dry food was successfully created." }
        format.json { render :show, status: :created, location: dry_foods_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dry_food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dry_foods/1 or /dry_foods/1.json
  def destroy
    @dry_food.destroy!

    respond_to do |format|
      format.html { redirect_to dry_foods_path, notice: "Dry food was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dry_food
      @dry_food = Current.user.dry_foods.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html do
          flash[:alert] = "Dry food not found."
          redirect_to dry_foods_path
        end
        format.json { render json: { error: "Dry food not found" }, status: :not_found }
      end
    end

    # Only allow a list of trusted parameters through.
    def dry_food_params
      params.require(:dry_food).permit(:brand, :food_type, :description, :amount, :used_amount, :user_id)
    end
end
