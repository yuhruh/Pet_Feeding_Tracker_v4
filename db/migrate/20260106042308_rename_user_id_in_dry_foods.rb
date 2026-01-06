class RenameUserIdInDryFoods < ActiveRecord::Migration[7.1]
  def change
    remove_index :dry_foods, name: "index_dry_foods_on_User_id"
    rename_column :dry_foods, :User_id, :user_id
    add_index :dry_foods, :user_id
  end
end
