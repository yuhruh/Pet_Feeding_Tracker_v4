class AddByteSizeToSolidCacheEntries < ActiveRecord::Migration[8.0]
  def change
    add_column :solid_cache_entries, :byte_size, :integer, limit: 8, null: false, default: 0
  end
end
