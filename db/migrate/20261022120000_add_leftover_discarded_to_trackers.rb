class AddLeftoverDiscardedToTrackers < ActiveRecord::Migration[8.1]
  def change
    add_column :trackers, :leftover_discarded, :boolean, default: false, null: false
  end
end
