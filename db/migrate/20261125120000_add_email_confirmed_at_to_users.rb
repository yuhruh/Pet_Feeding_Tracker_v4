# Sign-up now asks people to confirm their email address (security scan F24).
# Accounts made before this count as confirmed, so nothing changes for them.
class AddEmailConfirmedAtToUsers < ActiveRecord::Migration[8.1]
  def up
    add_column :users, :email_confirmed_at, :datetime
    execute "UPDATE users SET email_confirmed_at = created_at"
  end

  def down
    remove_column :users, :email_confirmed_at
  end
end
