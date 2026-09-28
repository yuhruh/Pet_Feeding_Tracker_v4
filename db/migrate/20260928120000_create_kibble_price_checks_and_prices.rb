class CreateKibblePriceChecksAndPrices < ActiveRecord::Migration[8.1]
  def change
    # One monthly (or "Refresh now") price check of a pet's favorite kibbles.
    create_table :kibble_price_checks do |t|
      t.references :pet, null: false, foreign_key: true
      t.date :checked_on, null: false
      t.string :status, null: false, default: "pending"
      t.string :error_message
      # One entry per favorite kibble checked, so a kibble with no prices can still be
      # shown: brand, description, favorite_score, queries, and how Gemini was used.
      t.json :kibbles, null: false, default: []
      t.timestamps
    end
    # At most one check per pet a day, however often the job or the button runs.
    add_index :kibble_price_checks, [ :pet_id, :checked_on ], unique: true

    create_table :kibble_prices do |t|
      t.references :kibble_price_check, null: false, foreign_key: true
      t.string :brand, null: false
      t.string :description, null: false
      t.integer :favorite_score
      t.string :source, null: false
      t.string :store
      t.string :url
      t.string :product_title, null: false
      # The option the price is for, when a listing sells several ("鴨肉｜體態管理配方 2kg").
      t.string :variant
      t.integer :price_twd, null: false
      # The size as the shop writes it ("2kg x 2"), for display.
      t.string :bag_size_label, null: false
      # The total in kg (4.0), only for working out price_per_kg.
      t.decimal :bag_size_kg, precision: 8, scale: 3, null: false
      t.decimal :price_per_kg, precision: 10, scale: 1, null: false
      t.boolean :suspicious, null: false, default: false
      t.string :suspicious_reason
      t.timestamps
    end
  end
end
