# Delete a mistaken record (checkpoint H3): the record is hidden like an undone
# tap, and who deleted it is kept.
class AddDeletedByToCareEvents < ActiveRecord::Migration[8.1]
  def change
    add_reference :care_events, :deleted_by, foreign_key: { to_table: :users }
  end
end
