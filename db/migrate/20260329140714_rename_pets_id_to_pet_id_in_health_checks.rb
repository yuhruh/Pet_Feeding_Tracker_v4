class RenamePetsIdToPetIdInHealthChecks < ActiveRecord::Migration[8.0]
  def change
    rename_column :health_checks, :pets_id, :pet_id
  end
end
