class AddArchivedDryFoodToTrackers < ActiveRecord::Migration[8.0]
  def change
    add_column :trackers, :archived_dry_food, :boolean, default: false, null: false
  end
end
