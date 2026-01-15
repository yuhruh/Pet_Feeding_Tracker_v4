class CsvImportTrackersService
  require "csv"
  # include TrackersCalculable

  def initialize(pet)
    @pet = pet
  end

  def call(file)
    begin
      file = File.open(file)
      csv = CSV.parse(file, headers: true)
      p "CSV Headers: #{csv.headers}" # This is for debugging
      csv.each do |row|
        tracker_hash = Hash.new
        tracker_hash[:date] = row["date"]
        tracker_hash[:feed_time] = row["feed_time"]
        tracker_hash[:come_back_to_eat] = row["come_back_to_eat"]
        tracker_hash[:food_type] = row["food_type"]
        tracker_hash[:brand] = row["brand"]
        tracker_hash[:description] = row["description"]
        tracker_hash[:amount] = row["amount"]
        tracker_hash[:left_amount] = row["left_amount"]
        tracker_hash[:total_ate_amount] = row["amount"].to_f - row["left_amount"].to_f if row["left_amount"].present?
        tracker_hash[:hungry] = row["hungry"]
        tracker_hash[:love] = row["love"]
        tracker_hash[:result] = [ row["hungry"].to_s.first, row["love"].to_s.first ].join(" - ") if row["hungry"].present? && row["love"].present?
        tracker_hash[:note] = row["note"] if row["note"].present?
        tracker_hash[:weight] = row["weight"] if row["weight"].present?
        eat_frequency = calculate_frequency(row["come_back_to_eat"]) if row["come_back_to_eat"].present?
        tracker_hash[:frequency] = eat_frequency.to_i
        tracker_hash[:favorite_score] = calculate_favorite([ row["hungry"].to_s.first, row["love"].to_s.first ], row["left_amount"].to_f, row["amount"].to_f, eat_frequency.to_i) if eat_frequency.present?
        # binding.b
        @pet.trackers.create(tracker_hash)
      end
    rescue CSV::MalformedCSVError => e
      redirect_to pet_trackers_path, alert: "Failed to parse CSV file: #{e.message}"
    end
  end

  private

    def calculate_frequency(time_string)
      time_string == "-" ? 0 : time_string.split(", ").count if time_string.present?
    end

    def calculate_favorite(arr, left_amount, amount, frequency)
      hungry = { "💖": 10, "🔺": 5, "❌": 0 }
      love = { "💕": 15,  "🔺": 5, "❌": 0 }

      hungry_score = hungry[arr[0].to_sym]
      love_score = love[arr[1].to_sym]
      left_amount_score = left_amount.to_f < (amount.to_f)/4 ? 15 : 8
      frequent_score = frequency * 2

      hungry_score.to_i + love_score.to_i + left_amount_score + frequent_score
    end
end
