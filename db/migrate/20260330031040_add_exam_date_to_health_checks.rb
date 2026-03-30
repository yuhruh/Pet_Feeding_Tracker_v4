class AddExamDateToHealthChecks < ActiveRecord::Migration[8.0]
  def change
    add_column :health_checks, :exam_date, :date
  end
end
