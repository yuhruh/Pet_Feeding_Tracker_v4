# Live updates (checkpoint G) go through Solid Cable, which production's
# config/cable.yml already names, but its table was never created: production
# shares one PostgreSQL database, so it comes in like Solid Queue's tables did.
class CreateSolidCableMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :solid_cable_messages do |t|
      t.binary :channel, limit: 1024, null: false
      t.binary :payload, limit: 536_870_912, null: false
      t.datetime :created_at, null: false
      t.integer :channel_hash, limit: 8, null: false
      t.index :channel
      t.index :channel_hash
      t.index :created_at
    end
  end
end
