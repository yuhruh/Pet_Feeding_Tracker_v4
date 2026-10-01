# Reminders (checkpoint H): how often each litter box or water spot job is due,
# and what was sent to whom, so a reminder goes out once.
class CreateCareRoutinesAndReminders < ActiveRecord::Migration[8.1]
  def change
    create_table :care_routines do |t|
      t.references :care_spot, null: false, foreign_key: true
      t.string :action, null: false
      t.integer :every_days, null: false
      t.date :started_on, null: false
      t.timestamps
      t.index %i[care_spot_id action], unique: true
    end

    create_table :care_reminders do |t|
      t.references :household, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :care_routine, foreign_key: { on_delete: :cascade }
      t.references :medication, foreign_key: { on_delete: :cascade }
      # "routine:12:2026-10-03" or "dose:7:2026-10-03:20:00": one reminder per person.
      t.string :key, null: false
      t.date :due_on, null: false
      t.string :channel, null: false
      t.datetime :sent_at, null: false
      t.datetime :follow_up_sent_at
      t.timestamps
      t.index %i[user_id key], unique: true
    end

    add_column :household_memberships, :reminders_enabled, :boolean, default: false, null: false
    add_column :households, :owner_reminders_enabled, :boolean, default: false, null: false
  end
end
