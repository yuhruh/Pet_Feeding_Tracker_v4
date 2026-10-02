# Android app notifications (checkpoint I): a phone's Firebase token, for the
# person signed in on it, in that sign-in session (signing out removes it).
class CreateDeviceTokens < ActiveRecord::Migration[8.1]
  def change
    create_table :device_tokens do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :session, foreign_key: { on_delete: :cascade }
      t.string :platform, null: false, default: "android"
      t.string :token, null: false
      t.datetime :last_used_at
      t.timestamps
      t.index :token, unique: true
    end
  end
end
