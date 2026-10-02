class PetsController < ApplicationController
  include PetAccess
  before_action :set_pet, only: %i[ show edit update destroy ]

  # GET /pets or /pets.json
  def index
    @pets = Current.user.owned_pets.paginate(page: params[:page], per_page: 5)
  end

  # GET /pets/1 or /pets/1.json
  def show
  end

  # GET /pets/new
  def new
    @pet = Pet.new
  end

  # GET /pets/1/edit
  def edit
  end

  # POST /pets or /pets.json
  def create
    # Into the user's own household, created with their first cat.
    @pet = Household.for_owner(Current.user).pets.build(pet_params)

    respond_to do |format|
      if @pet.save
        format.html { redirect_to pet_url(@pet), notice: t(".notice") }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render_json_validation_errors(@pet) }
      end
    end
  end

  # PATCH/PUT /pets/1 or /pets/1.json
  def update
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to @pet, notice: t(".notice", petname: @pet.petname.capitalize), status: :see_other }
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render_json_validation_errors(@pet) }
      end
    end
  end

  # DELETE /pets/1 or /pets/1.json
  def destroy
    name = @pet.petname
    @pet.destroy!

    respond_to do |format|
      format.html { redirect_to pets_path, notice: t(".notice", name: name), status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # A pet's profile is its owner's to see and change; anyone else's pet is not found.
    def set_pet
      load_pet(params.expect(:id), :manage_pet)
    end

    # Only allow a list of trusted parameters through.
    def pet_params
      params.expect(pet: [ :pet_avatar, :petname, :birthday, :weight, :gender, :breed ])
    end
end
