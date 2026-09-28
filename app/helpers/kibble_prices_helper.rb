module KibblePricesHelper
  # NT$1,450
  def kibble_twd(amount, precision: 0)
    number_to_currency(amount, unit: "NT$", precision: precision, format: "%u%n")
  end

  # "2kg x 2 (4 kg)"; just "4kg" when the shop's label already says the total in kg.
  def kibble_bag_size(price)
    kg = number_with_precision(price.bag_size_kg, precision: 3, strip_insignificant_zeros: true)
    return price.bag_size_label if price.bag_size_label.match?(/\A#{Regexp.escape(kg)}\s*(kg|公斤)\z/i)

    "#{price.bag_size_label} (#{kg} kg)"
  end

  # The product linked to the shop's page. Links come from other sites, so only
  # http(s) ones become links, and they open without passing this page on.
  def kibble_product_link(price, **options)
    uri = URI.parse(price.url.to_s)
    return price.product_title unless uri.is_a?(URI::HTTP) && uri.host.present?

    link_to price.product_title, uri.to_s, target: "_blank", rel: "noopener noreferrer nofollow", **options
  rescue URI::InvalidURIError
    price.product_title
  end
end
