class CsvImportTrackersService
  require "csv"
  include TrackersCalculable

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
        tracker_hash[:total_ate_amount] = row["amount"].to_f - row["left_amount"].to_f
        tracker_hash[:hungry] = row["hungry"]
        tracker_hash[:love] = row["love"]
        tracker_hash[:result] = [row["hungry"].to_s.first, row["love"].to_s.first].join(" - ") if row["hungry"].present? && row["love"].present?
        tracker_hash[:note] = row["note"] if row["note"].present?       
        tracker_hash[:weight] = row["weight"] if row["weight"].present?
        tracker_hash[:frequency] = calculate_frequency(row["come_back_to_eat"])
        binding.b
        tracker_hash[:favorite_score] = calculate_favorite(row["hungry"], row["love"], row["left_amount"], row["amount"], tracker_hash[:frequency])
        
        @pet.trackers.create(tracker_hash)
      end
    rescue CSV::MalformedCSVError => e
      redirect_to pet_trackers_path, alert: "Failed to parse CSV file: #{e.message}"
    end
  end
end