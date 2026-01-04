class FixUserIdInPets < ActiveRecord::Migration[8.0]
  def change
    # The create_pets migration incorrectly added both a user_id and a users_id.
    # The foreign key and index are on users_id.
    # This migration will fix the schema to have a single user_id column with the
    # foreign key and index.

    # To be safe, first remove the foreign key and index on users_id
    remove_foreign_key :pets, column: :users_id
    remove_index :pets, name: "index_pets_on_users_id"

    # remove the extra user_id column
    remove_column :pets, :user_id

    # rename users_id to user_id
    rename_column :pets, :users_id, :user_id

    # add the index and foreign key back on the correct column
    add_index :pets, :user_id
    add_foreign_key :pets, :users
  end
end
