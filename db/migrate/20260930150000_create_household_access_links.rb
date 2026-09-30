class CreateHouseholdAccessLinks < ActiveRecord::Migration[8.1]
  def change
    # An owner's invitation for one email address to join as a caregiver.
    create_table :household_invitations do |t|
      t.references :household, null: false, foreign_key: true
      # nil once the person who invited deletes their account.
      t.references :invited_by, foreign_key: { to_table: :users }
      t.string :email, null: false
      t.string :token_digest, null: false, index: { unique: true }
      t.datetime :expires_at, null: false
      t.datetime :accepted_at
      t.references :accepted_by, foreign_key: { to_table: :users }
      t.timestamps
    end

    # A personal read-only link for one viewer, e.g. "Grandma"; no account needed.
    create_table :viewer_links do |t|
      t.references :household, null: false, foreign_key: true
      # nil once the person who created it deletes their account; the link keeps working.
      t.references :created_by, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.string :token_digest, null: false, index: { unique: true }
      t.datetime :expires_at
      t.datetime :revoked_at
      t.datetime :last_used_at
      t.timestamps
    end

    # An owner handing the household to one of its members, who must accept.
    create_table :ownership_transfers do |t|
      t.references :household, null: false, foreign_key: true
      t.references :from_user, null: false, foreign_key: { to_table: :users }
      t.references :to_user, null: false, foreign_key: { to_table: :users }
      t.string :token_digest, null: false, index: { unique: true }
      t.datetime :expires_at, null: false
      t.datetime :accepted_at
      t.datetime :cancelled_at
      t.timestamps
    end
  end
end
