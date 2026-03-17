class ChangeArchivedDryFoodDefaultOnTrackers < ActiveRecord::Migration[8.0]
  def change
    change_column_default :trackers, :archived_dry_food, from: nil, to: false
    
    # Optional: Update existing nil records to false
    # Tracker.where(archived_dry_food: nil).update_all(archived_dry_food: false)
    reversible do |dir|
      dir.up do
        execute("UPDATE trackers SET archived_dry_food = 'f' WHERE archived_dry_food IS NULL")
      end
    end

    # Sets the null constraint
    change_column_null :trackers, :archived_dry_food, false
  end
end
