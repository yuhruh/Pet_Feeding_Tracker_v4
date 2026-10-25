class CreateDriveBackups < ActiveRecord::Migration[8.1]
  def change
    create_table :drive_backups do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.text :refresh_token
      t.string :google_email
      t.string :folder_id
      t.json :file_ids, default: {}, null: false
      t.integer :backup_hour, default: 23, null: false
      t.datetime :last_attempted_at
      t.datetime :last_backed_up_at
      t.string :last_error
      t.timestamps
    end
  end
end
