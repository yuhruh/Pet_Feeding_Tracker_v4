class DryFoodsController < ApplicationController
  before_action :set_dry_food, only: %i[ show edit update destroy ]

  # GET /dry_foods or /dry_foods.json
  def index
    @dry_foods = DryFood.all
  end

  # GET /dry_foods/1 or /dry_foods/1.json
  def show
  end

  # GET /dry_foods/new
  def new
    @dry_food = DryFood.new
  end

  # GET /dry_foods/1/edit
  def edit
  end

  # POST /dry_foods or /dry_foods.json
  def create
    @dry_food = DryFood.new(dry_food_params)

    respond_to do |format|
      if @dry_food.save
        format.html { redirect_to @dry_food, notice: "Dry food was successfully created." }
        format.json { render :show, status: :created, location: @dry_food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dry_food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dry_foods/1 or /dry_foods/1.json
  def update
    respond_to do |format|
      if @dry_food.update(dry_food_params)
        format.html { redirect_to @dry_food, notice: "Dry food was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @dry_food }
      else
        format.html { render :edit, status: :unprocessable_entity }
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
      @dry_food = DryFood.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def dry_food_params
      params.expect(dry_food: [ :brand, :food_type, :description, :amount, :used_amount, :average_used_amount, :total_ate_amount, :left_amount, :days_remaining, :user_id ])
    end
end
