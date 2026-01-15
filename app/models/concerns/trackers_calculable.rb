module TrackersCalculable
  extend ActiveSupport::Concern

  def calculate_frequency(time_string)
    time_string.to_s == "-" ? 0 : time_string.to_s.split(", ").count
  end

  def calculate_favorite(hungry_str, love_str, left_amount, amount, frequency)
    hungry = { "💖": 10, "🔺": 5, "❌": 0 }
    love = { "💕": 15,  "🔺": 5, "❌": 0 }

    hungry_score = hungry[hungry_str.to_s.to_sym].to_i
    love_score = love[love_str.to_s.to_sym].to_i
    left_amount_score = left_amount.to_f < (amount.to_f / 4) ? 15 : 8
    frequent_score = frequency.to_i * 2

    hungry_score + love_score + left_amount_score + frequent_score
  end
end
