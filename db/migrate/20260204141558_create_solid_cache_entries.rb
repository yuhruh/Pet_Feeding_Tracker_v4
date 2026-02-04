class CreateSolidCacheEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_cache_entries do |t|
      # The 64-bit hash Rails 8 uses for lookups
      t.integer  :key_hash,   null: false, limit: 8
      t.binary   :key,        null: false, limit: 1024
      t.binary   :value,      null: false, limit: 512.megabytes
      t.datetime :created_at, null: false

      # Indexes for performance
      t.index :key_hash, unique: true
      t.index [ :key_hash, :created_at ]
    end
  end
end