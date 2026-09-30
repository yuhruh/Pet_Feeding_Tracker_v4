# One-tap care: fed, weight (per cat), litter and water (per litter box or water
# spot). Medications (checkpoint E) and litter observations (F) add to this table.
class CreateCareEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :care_events do |t|
      t.references :household, null: false, foreign_key: true
      t.references :actor, foreign_key: { to_table: :users }
      t.string :kind, null: false
      t.datetime :occurred_at, null: false
      t.references :pet, foreign_key: true, index: false
      t.references :care_spot, foreign_key: true, index: false
      t.json :actions, null: false, default: []
      t.json :details, null: false, default: {}
      t.decimal :value, precision: 5, scale: 2
      t.string :note
      t.references :tracker, foreign_key: true
      t.references :edited_by, foreign_key: { to_table: :users }, index: false
      t.datetime :edited_at
      t.datetime :undone_at
      t.timestamps
    end
    add_index :care_events, %i[pet_id kind occurred_at]
    add_index :care_events, %i[care_spot_id occurred_at]
    add_index :care_events, %i[household_id occurred_at]
  end
end
