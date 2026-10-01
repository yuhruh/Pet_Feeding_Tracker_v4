# A cat's medications, and the doses recorded as care events.
class CreateMedications < ActiveRecord::Migration[8.1]
  def change
    create_table :medications do |t|
      t.references :pet, null: false, foreign_key: true
      t.string :name, null: false
      t.string :dose
      t.json :times, null: false, default: []
      t.date :starts_on, null: false
      t.date :ends_on
      t.datetime :stopped_at
      t.timestamps
    end

    add_reference :care_events, :medication, foreign_key: true, index: false
    add_column :care_events, :dose_time, :string
    add_column :care_events, :dose_status, :string
    add_column :care_events, :reason, :string
    add_index :care_events, %i[medication_id occurred_at]
  end
end
