# The owner's litter boxes and water spots: add, rename, bowl or fountain,
# reorder, remove. Removing archives a spot, so past records keep its name.
class CareSpotsController < ApplicationController
  include OwnedHousehold

  before_action :set_spot, only: %i[update move destroy]

  def create
    spot = @household.care_spots.new(spot_params)
    spot.position = @household.care_spots.maximum(:position).to_i + 1
    if spot.save
      redirect_to household_path(anchor: "care_spots"), notice: t(".notice", name: helpers.care_spot_name(spot))
    else
      redirect_to household_path(anchor: "care_spots"), alert: spot.errors.map(&:message).to_sentence
    end
  end

  def update
    attributes = spot_params
    # A litter box stays a litter box; a water spot can be a bowl or a fountain.
    attributes.delete(:kind) if @spot.litter_box? || attributes[:kind] == "litter_box"
    if @spot.update(attributes)
      redirect_to household_path(anchor: "care_spots"), notice: t(".notice")
    else
      redirect_to household_path(anchor: "care_spots"), alert: @spot.errors.map(&:message).to_sentence
    end
  end

  def move
    spots = @household.care_spots.active.to_a
    index = spots.index(@spot)
    target = params[:direction] == "up" ? index - 1 : index + 1
    if target.between?(0, spots.size - 1)
      spots[index], spots[target] = spots[target], spots[index]
      spots.each_with_index { |spot, position| spot.update_column(:position, position) }
    end
    redirect_to household_path(anchor: "care_spots"), status: :see_other
  end

  def destroy
    @spot.update!(archived_at: Time.current)
    redirect_to household_path(anchor: "care_spots"), notice: t(".notice", name: helpers.care_spot_name(@spot)), status: :see_other
  end

  private

  def set_spot
    @spot = @household.care_spots.active.find(params[:id])
  end

  def spot_params
    params.expect(care_spot: [ :name, :kind ])
  end
end
