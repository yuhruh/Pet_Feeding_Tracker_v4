class AddTestsToHealthCheck < ActiveRecord::Migration[8.0]
  def change
    add_column :health_checks, :glob, :decimal
    add_column :health_checks, :fbnp, :string
    add_column :health_checks, :felv, :string
    add_column :health_checks, :fiv, :string
    add_column :health_checks, :fpl2, :decimal
  end
end
