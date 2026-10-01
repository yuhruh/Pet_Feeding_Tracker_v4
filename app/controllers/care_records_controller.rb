# The owner's CSV download of the household's care records (checkpoint G).
class CareRecordsController < ApplicationController
  include OwnedHousehold

  def show
    csv = CareRecordsCsv.new(@household, helpers)
    respond_to do |format|
      format.csv { send_data csv.to_csv, filename: csv.filename, type: "text/csv" }
    end
  end
end
