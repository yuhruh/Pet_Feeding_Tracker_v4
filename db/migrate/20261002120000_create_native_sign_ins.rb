# Sign in with Google, LINE or GitHub in the Android app (checkpoint I2): the
# provider sign-in happens in Chrome, and a one-time code brings the result into
# the app's WebView. Only a digest of the code is stored.
class CreateNativeSignIns < ActiveRecord::Migration[8.1]
  def change
    create_table :native_sign_ins do |t|
      t.string :token_digest, null: false
      t.references :user, foreign_key: { on_delete: :cascade } # none for a refusal
      t.string :path, null: false
      t.json :flash, default: {}, null: false
      t.json :data, default: {}, null: false
      t.datetime :expires_at, null: false
      t.datetime :used_at
      t.timestamps
      t.index :token_digest, unique: true
    end
  end
end
