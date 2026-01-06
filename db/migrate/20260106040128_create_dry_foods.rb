class CreateDryFoods < ActiveRecord::Migration[8.0]
  def change
    create_table :dry_foods do |t|
      t.string :brand
      t.string :food_type
      t.string :description
      t.decimal :amount
      t.decimal :used_amount
      t.decimal :average_used_amount
      t.decimal :total_ate_amount
      t.decimal :left_amount
      t.date :days_remaining
      t.references :User, null: false, foreign_key: true

      t.timestamps
    end
  end
end
