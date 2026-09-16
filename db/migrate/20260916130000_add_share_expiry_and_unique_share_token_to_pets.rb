class AddShareExpiryAndUniqueShareTokenToPets < ActiveRecord::Migration[8.1]
  def up
    add_column :pets, :share_expires_at, :datetime

    # Pets used to get a link the first time their trackers page was opened. Give the rest
    # one now, so turning sharing off becomes an explicit choice, and blank values
    # can't collide under the unique index.
    select_values("SELECT id FROM pets WHERE share_token IS NULL OR share_token = ''").each do |id|
      execute "UPDATE pets SET share_token = #{quote(SecureRandom.urlsafe_base64(16))} WHERE id = #{Integer(id)}"
    end

    remove_index :pets, :share_token
    add_index :pets, :share_token, unique: true
  end

  def down
    remove_index :pets, :share_token
    add_index :pets, :share_token
    remove_column :pets, :share_expires_at
  end
end
