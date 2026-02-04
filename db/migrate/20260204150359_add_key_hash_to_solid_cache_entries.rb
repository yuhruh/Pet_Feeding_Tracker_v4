class AddKeyHashToSolidCacheEntries < ActiveRecord::Migration[8.0]
  def change
    # Add key_hash only if it doesn't already exist (safety check for Render)
    unless column_exists?(:solid_cache_entries, :key_hash)
      add_column :solid_cache_entries, :key_hash, :integer, limit: 8, null: false
      add_index :solid_cache_entries, :key_hash, unique: true
      add_index :solid_cache_entries, :key_hash, :created_at
    end
  end
end
