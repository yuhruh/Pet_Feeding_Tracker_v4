module KibblePrices
  # Reads the bag size a shop sells from a listing title or variant name:
  # "2kg" => 2, "300克" => 0.3, "3.3lb" => 1.5, "4kg 2包組" => 8, "150g 2包" => 0.3.
  module BagSize
    KG_PER_UNIT = {
      "kg" => 1, "公斤" => 1,
      "g" => 0.001, "公克" => 0.001, "克" => 0.001,
      "lb" => 0.45359237, "lbs" => 0.45359237, "磅" => 0.45359237
    }.freeze

    SIZE = /(\d+(?:\.\d+)?)\s*(公斤|公克|kg|lbs|lb|g|克|磅)(?![a-z])/i
    # A pack count: "x 2", "*2", "2包組", "2入", "【3包】", "1個".
    PACK = /(?:[x×*]\s*(\d{1,2})(?![\d.]|\s*(?:kg|g|lb|公斤|公克|克|磅))|[【\[(]?(\d{1,2})\s*(?:包組|入組|袋組|件組|包|入|袋|件|個)[】\])]?)/i
    # Shipping limits such as "超取最多2件" or "超商限2包" are not pack counts.
    SHIPPING_LIMIT = /(?:超商|超取|宅配)?(?:最多|限)\s*\d+\s*[包件袋入]/

    # Returns { kg:, label: }, or nil when there is no size or several different
    # sizes (a listing that sells "2kg/4kg" with one price).
    def self.parse(text)
      text = text.to_s.unicode_normalize(:nfkc).gsub(SHIPPING_LIMIT, " ")
      sizes = text.to_enum(:scan, SIZE).map { Regexp.last_match }
      return if sizes.empty?

      distinct_kg = sizes.map { |m| (m[1].to_f * KG_PER_UNIT.fetch(m[2].downcase)).round(3) }.uniq
      return if distinct_kg.size > 1 || distinct_kg.first <= 0

      size = sizes.first
      pack = PACK.match(text, size.end(0))
      count = pack ? (pack[1] || pack[2]).to_i : 1
      count = 1 if count < 1
      label_end = pack && count > 1 ? pack.end(0) : size.end(0)

      { kg: (distinct_kg.first * count).round(3), label: text[size.begin(0)...label_end].squish }
    end
  end
end
