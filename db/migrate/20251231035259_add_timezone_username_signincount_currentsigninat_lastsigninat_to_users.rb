class AddTimezoneUsernameSignincountCurrentsigninatLastsigninatToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :username, :string
    add_column :users, :timezone, :string
    add_column :users, :sing_in_count, :integer
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
  end
end
