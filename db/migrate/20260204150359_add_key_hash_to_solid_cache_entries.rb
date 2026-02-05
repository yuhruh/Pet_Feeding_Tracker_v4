class AddKeyHashToSolidCacheEntries < ActiveRecord::Migration[8.0]
  def change
    unless column_exists?(:solid_cache_entries, :key_hash)
      # 1. Add the column (Allowing NULL temporarily to avoid build crashes)
      add_column :solid_cache_entries, :key_hash, :integer, limit: 8

      # 2. Add the indexes (Corrected syntax)
      add_index :solid_cache_entries, :key_hash, unique: true
      add_index :solid_cache_entries, [ :key_hash, :created_at ] # Array brackets are required here

      # 3. Clear existing cache (Safe since it's just cache)
      execute("DELETE FROM solid_cache_entries")

      # 4. Now enforce the constraint
      change_column_null :solid_cache_entries, :key_hash, false
    end
  end
end
