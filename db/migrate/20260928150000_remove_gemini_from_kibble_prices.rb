class RemoveGeminiFromKibblePrices < ActiveRecord::Migration[8.1]
  # Gemini is no longer a price source. Its prices were the only ones ever
  # marked suspicious, so that goes too.
  def up
    execute "DELETE FROM kibble_prices WHERE source = 'Gemini'"
    remove_column :kibble_prices, :suspicious
    remove_column :kibble_prices, :suspicious_reason
  end

  def down
    add_column :kibble_prices, :suspicious, :boolean, null: false, default: false
    add_column :kibble_prices, :suspicious_reason, :string
  end
end
