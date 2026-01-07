class CreateTrackers < ActiveRecord::Migration[8.0]
  def change
    create_table :trackers do |t|
      t.date :date
      t.time :feed_time
      t.string :come_back_to_eat
      t.string :food_type
      t.string :brand
      t.string :description
      t.string :hungry
      t.decimal :amount, precision: 5, scale: 2
      t.decimal :left_amount, precision: 5, scale: 2
      t.string :love
      t.decimal :total_ate_amount, precision: 5, scale: 2
      t.integer :frequency
      t.string :result
      t.integer :favorite_score, default: 0
      t.string :note
      t.decimal :weight, precision: 4, scale: 2
      t.references :pet, null: false, foreign_key: true
      t.references :dry_food, null: false, foreign_key: true

      t.timestamps
    end
  end
end
