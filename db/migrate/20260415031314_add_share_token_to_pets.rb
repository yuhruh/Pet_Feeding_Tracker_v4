class AddShareTokenToPets < ActiveRecord::Migration[8.0]
  def change
    add_column :pets, :share_token, :string
    add_index :pets, :share_token
  end
end
