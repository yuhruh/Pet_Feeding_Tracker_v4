class CsvImportTrackersService
  require "csv"
  attr_reader :errors

  def initialize(pet, user)
    @pet = pet
    @user = user
    @errors = []
  end

  def call(file)
    ActiveRecord::Base.transaction do
      begin
        file = File.open(file)
        header_converter = lambda do |header|
          return header if header.nil?
          mapping = {
            Tracker.human_attribute_name(:date) => "date",
            Tracker.human_attribute_name(:feed_time) => "feed_time",
            Tracker.human_attribute_name(:come_back_to_eat) => "come_back_to_eat",
            Tracker.human_attribute_name(:food_type) => "food_type",
            Tracker.human_attribute_name(:brand) => "brand",
            Tracker.human_attribute_name(:description) => "description",
            Tracker.human_attribute_name(:amount) => "amount",
            Tracker.human_attribute_name(:left_amount) => "left_amount",
            Tracker.human_attribute_name(:total_ate_amount) => "total_ate_amount",
            Tracker.human_attribute_name(:hungry) => "hungry",
            Tracker.human_attribute_name(:love) => "love",
            Tracker.human_attribute_name(:result) => "result",
            Tracker.human_attribute_name(:note) => "note",
            Tracker.human_attribute_name(:weight) => "weight"
          }
          mapping[header] || header.to_s.downcase.gsub(/\(.*\)/, "").strip.gsub(" ", "_")
        end

        csv = CSV.parse(file, headers: true, col_sep: ";", header_converters: header_converter)
        csv.each_with_index do |row, i|
          tracker_hash = {}

          # Validate and convert data types
          validate_and_convert(row, i, tracker_hash)

          # If errors were found in validation, stop processing this file
          raise ActiveRecord::Rollback if @errors.any?

          tracker_hash[:come_back_to_eat] = row["come_back_to_eat"]
          tracker_hash[:food_type] = normalize_food_type(row["food_type"])
          tracker_hash[:brand] = row["brand"]
          tracker_hash[:description] = row["description"]
          tracker_hash[:hungry] = normalize_hungry(row["hungry"])
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
            @errors << I18n.t("services.csv_import.row_error", row: i + 2, message: e.message)
            raise ActiveRecord::Rollback
          end
        end
      rescue CSV::MalformedCSVError => e
        @errors << I18n.t("services.csv_import.failed_to_parse", message: e.message)
        raise ActiveRecord::Rollback
      rescue ActiveRecord::RecordInvalid => e
        # This will catch validation errors from the model, e.g. presence checks
        @errors << I18n.t("services.csv_import.failed_to_import", message: e.message)
        raise ActiveRecord::Rollback
      end
    end
    @errors.empty?
  end

  private

    def normalize_food_type(value)
      return nil if value.blank?

      # Try to match localized values or internal keys
      Tracker.food_types.keys.each do |key|
        if value == I18n.t("trackers.food_types.#{key}") || value.downcase == key.to_s.downcase || value == Tracker.food_types[key]
          return key
        end
      end
      value
    end

    def normalize_hungry(value)
      return nil if value.blank?

      # Try to match labels in HUNGRY_MAP or localized values
      Tracker::HUNGRY_MAP.each do |key, label|
        if value == label || value == I18n.t("trackers.hungry_options.#{key}")
          return key
        end
      end
      nil
    end

    def validate_and_convert(row, row_index, tracker_hash)
      begin
        if row["date"].present?
          parsed_date = Date.parse(row["date"])
          if parsed_date < @pet.birthday
            @errors << I18n.t("services.csv_import.row_error", row: row_index + 2, message: I18n.t("services.csv_import.date_earlier_than_birthday"))
          else
            tracker_hash[:date] = parsed_date
          end
        end
      rescue ArgumentError
        @errors << I18n.t("services.csv_import.row_error", row: row_index + 2, message: I18n.t("services.csv_import.invalid_date_format"))
      end

      begin
        Time.use_zone(@user.timezone) do
          if row["date"].present? && row["feed_time"].present? && tracker_hash[:date]
            tracker_hash[:feed_time] = Time.zone.parse("#{row["date"]} #{row["feed_time"]}")
          end
        end
      rescue ArgumentError
        @errors << I18n.t("services.csv_import.row_error", row: row_index + 2, message: I18n.t("services.csv_import.invalid_feed_time_format"))
      end

      begin
        tracker_hash[:amount] = Float(row["amount"]) if row["amount"].present?
      rescue ArgumentError
        @errors << I18n.t("services.csv_import.row_error", row: row_index + 2, message: I18n.t("services.csv_import.invalid_amount_number"))
      end

      begin
        tracker_hash[:left_amount] = Float(row["left_amount"]) if row["left_amount"].present?
      rescue ArgumentError
        @errors << I18n.t("services.csv_import.row_error", row: row_index + 2, message: I18n.t("services.csv_import.invalid_left_amount_number"))
      end

      begin
        tracker_hash[:weight] = Float(row["weight"]) if row["weight"].present?
      rescue ArgumentError
        @errors << I18n.t("services.csv_import.row_error", row: row_index + 2, message: I18n.t("services.csv_import.invalid_weight_number"))
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
