module KibblePrices
  # One product a shop lists. variant is the option the price is for, when the
  # listing sells several ("鴨肉｜體態管理配方 2kg").
  Listing = Struct.new(:source, :store, :title, :variant, :price_twd, :url, keyword_init: true)
end
