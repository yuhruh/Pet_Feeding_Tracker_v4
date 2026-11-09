# The owner's care records (checkpoint G): one day at a time as a page, where any
# record can be changed (and deleted up to 7 days back), or all of them as a CSV.
class CareRecordsController < ApplicationController
  include OwnedHousehold

  def show
    respond_to do |format|
      format.html { load_day }
      format.csv do
        csv = CareRecordsCsv.new(@household, helpers)
        send_data csv.to_csv, filename: csv.filename, type: "text/csv"
      end
    end
  end

  private

  def load_day
    @today = Time.current.in_time_zone(@household.time_zone).to_date
    @date = [ parse_date(params[:date]) || @today, @today ].min
    @day = HouseholdDay.new(@household, date: @date)
    @kind = params[:kind].presence_in(CareEvent.kinds.keys)
    @subject = params[:subject].presence
    @spots = @household.care_spots.order(:id).to_a
    @entries = @day.entries.select { |entry| shown?(entry) }
  end

  def parse_date(value)
    Date.iso8601(value.to_s)
  rescue Date::Error
    nil
  end

  # The filters: a type, and a cat ("pet-3") or a litter box or water spot ("spot-5").
  # A tracker logged directly is a feeding of its cat.
  def shown?(entry)
    return false if @kind && (entry.event&.kind || "fed") != @kind

    type, id = @subject.to_s.split("-", 2)
    case type
    when "pet" then entry.pet&.id.to_s == id
    when "spot" then entry.event&.care_spot_id.to_s == id
    else true
    end
  end
end
