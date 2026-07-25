class AddVetNameAndDurationToVetVisits < ActiveRecord::Migration[8.0]
  def change
    add_column :vet_visits, :vet_name, :string
    add_column :vet_visits, :consultation_time, :integer
  end
end
