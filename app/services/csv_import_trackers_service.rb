class CsvImportTrackersService
  require "csv"
  attr_reader :errors

  def initialize(pet)
    @pet = pet
    @errors = []
  end

  def call(file)
    ActiveRecord::Base.transaction do
      begin
        file = File.open(file)
        csv = CSV.parse(file, headers: true)
        csv.each_with_index do |row, i|
          tracker_hash = {}
          
          # Validate and convert data types
          validate_and_convert(row, i, tracker_hash)

          # If errors were found in validation, stop processing this file
          raise ActiveRecord::Rollback if @errors.any?

          tracker_hash[:come_back_to_eat] = row["come_back_to_eat"]
          tracker_hash[:food_type] = row["food_type"]
          tracker_hash[:brand] = row["brand"]
          tracker_hash[:description] = row["description"]
          tracker_hash[:hungry] = row["hungry"]
          tracker_hash[:love] = row["love"]
          tracker_hash[:note] = row["note"]

          tracker_hash[:total_ate_amount] = tracker_hash[:amount].to_f - tracker_hash[:left_amount].to_f if tracker_hash[:left_amount].present?
          tracker_hash[:result] = [ row["hungry"].to_s.first, row["love"].to_s.first ].join(" - ") if row["hungry"].present? && row["love"].present?
          eat_frequency = calculate_frequency(row["come_back_to_eat"]) if row["come_back_to_eat"].present?
          tracker_hash[:frequency] = eat_frequency.to_i
          tracker_hash[:favorite_score] = calculate_favorite([ row["hungry"].to_s.first, row["love"].to_s.first ], tracker_hash[:left_amount].to_f, tracker_hash[:amount].to_f, eat_frequency.to_i) if eat_frequency.present?
          
          begin
            @pet.trackers.create!(tracker_hash)
          rescue ArgumentError => e
            @errors << "Row #{i + 2}: #{e.message}"
            raise ActiveRecord::Rollback
          end
        end
      rescue CSV::MalformedCSVError => e
        @errors << "Failed to parse CSV file: #{e.message}"
        raise ActiveRecord::Rollback
      rescue ActiveRecord::RecordInvalid => e
        # This will catch validation errors from the model, e.g. presence checks
        @errors << "Failed to import data: #{e.message}"
        raise ActiveRecord::Rollback
      end
    end
    @errors.empty?
  end

  private

    def validate_and_convert(row, row_index, tracker_hash)
      begin
        tracker_hash[:date] = Date.parse(row["date"]) if row["date"].present?
      rescue ArgumentError
        @errors << "Row #{row_index + 2}: Invalid format for 'date' column."
      end

      begin
        tracker_hash[:feed_time] = Time.parse(row["feed_time"]) if row["feed_time"].present?
      rescue ArgumentError
        @errors << "Row #{row_index + 2}: Invalid format for 'feed_time' column."
      end

      begin
        tracker_hash[:amount] = Float(row["amount"]) if row["amount"].present?
      rescue ArgumentError
        @errors << "Row #{row_index + 2}: Invalid number for 'amount' column."
      end

      begin
        tracker_hash[:left_amount] = Float(row["left_amount"]) if row["left_amount"].present?
      rescue ArgumentError
        @errors << "Row #{row_index + 2}: Invalid number for 'left_amount' column."
      end

      begin
        tracker_hash[:weight] = Float(row["weight"]) if row["weight"].present?
      rescue ArgumentError
        @errors << "Row #{row_index + 2}: Invalid number for 'weight' column."
      end
    end

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
