class RenameSingInCountToSignInCountInUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :sing_in_count, :sign_in_count
  end
end