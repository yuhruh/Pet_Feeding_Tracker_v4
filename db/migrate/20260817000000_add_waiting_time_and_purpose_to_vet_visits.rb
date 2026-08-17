class AddWaitingTimeAndPurposeToVetVisits < ActiveRecord::Migration[8.1]
  def change
    add_column :vet_visits, :waiting_time, :integer
    add_column :vet_visits, :purpose, :string
  end
end
