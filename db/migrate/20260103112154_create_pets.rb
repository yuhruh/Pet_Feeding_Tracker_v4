class CreatePets < ActiveRecord::Migration[8.0]
  def change
    create_table :pets do |t|
      t.string :petname
      t.datetime :birthday
      t.decimal :weight
      t.string :gender
      t.string :breed
      t.integer :user_id
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
