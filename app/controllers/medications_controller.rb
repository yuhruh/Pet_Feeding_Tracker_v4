# The owner's list of a cat's medications: add, change, stop. Caregivers record
# doses on the Today page but don't change the list.
class MedicationsController < ApplicationController
  include PetAccess

  before_action { load_pet(params[:pet_id], :manage_medications) }
  before_action :set_medication, only: %i[update destroy]

  def index
    @medications = @pet.medications.current.order(:name)
    @stopped = @pet.medications.where.not(stopped_at: nil).order(stopped_at: :desc).limit(10)
    @medication = @pet.medications.new(starts_on: Date.current)
  end

  def create
    medication = @pet.medications.new(medication_params)
    if medication.save
      redirect_to pet_medications_path(@pet), notice: t(".notice", name: medication.name)
    else
      redirect_to pet_medications_path(@pet), alert: medication.errors.map(&:message).to_sentence
    end
  end

  def update
    if @medication.update(medication_params)
      redirect_to pet_medications_path(@pet), notice: t(".notice", name: @medication.name)
    else
      redirect_to pet_medications_path(@pet), alert: @medication.errors.map(&:message).to_sentence
    end
  end

  # Stopping keeps the medication and its doses on the timeline.
  def destroy
    @medication.update!(stopped_at: Time.current)
    redirect_to pet_medications_path(@pet), notice: t(".notice", name: @medication.name), status: :see_other
  end

  private

  def set_medication
    @medication = @pet.medications.current.find(params[:id])
  end

  def medication_params
    params.expect(medication: [ :name, :dose, :starts_on, :ends_on, times: [] ])
  end
end
