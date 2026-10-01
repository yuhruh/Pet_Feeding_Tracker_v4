# Litter several times a day (checkpoint H2): per job, the owner picks "every …"
# (now in hours, so "twice a day" fits) or "at set times" (up to 6 a day).
# Existing intervals carry over unchanged, as hours.
class AddSetTimesToCareRoutines < ActiveRecord::Migration[8.1]
  def up
    add_column :care_routines, :mode, :string, default: "every", null: false
    add_column :care_routines, :every_hours, :integer
    add_column :care_routines, :times, :json, default: [], null: false
    execute "UPDATE care_routines SET every_hours = every_days * 24"
    remove_column :care_routines, :every_days
  end

  def down
    add_column :care_routines, :every_days, :integer
    # Set times and intervals under a day become "daily".
    execute "UPDATE care_routines SET every_days = CASE WHEN every_hours >= 24 THEN every_hours / 24 ELSE 1 END"
    change_column_null :care_routines, :every_days, false
    remove_column :care_routines, :times
    remove_column :care_routines, :every_hours
    remove_column :care_routines, :mode
  end
end
