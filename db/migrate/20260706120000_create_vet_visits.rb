class CreateVetVisits < ActiveRecord::Migration[8.0]
  def change
    create_table :vet_visits do |t|
      t.references :pet, null: false, foreign_key: true
      t.text :question, null: false
      t.text :answer
      t.date :visit_date, null: false
      t.date :answered_date

      t.timestamps
    end

    create_table :vet_visit_members do |t|
      t.references :vet_visit, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :vet_visit_members, [ :vet_visit_id, :user_id ], unique: true
  end
end
