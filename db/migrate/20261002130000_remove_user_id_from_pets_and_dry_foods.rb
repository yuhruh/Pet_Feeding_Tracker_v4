# Checkpoint J: cats and food bags belong to their household only. user_id was
# kept in step with the household's owner since checkpoint A; rolling back
# fills it again from the owner.
class RemoveUserIdFromPetsAndDryFoods < ActiveRecord::Migration[8.1]
  TABLES = %i[pets dry_foods].freeze

  def up
    # Dropping the column drops its index and foreign key too, and only those.
    TABLES.each { |table| remove_column table, :user_id }
  end

  def down
    TABLES.each do |table|
      add_reference table, :user, foreign_key: true
      execute "UPDATE #{table} SET user_id = (SELECT owner_id FROM households WHERE households.id = #{table}.household_id)"
      change_column_null table, :user_id, false
    end
  end
end
