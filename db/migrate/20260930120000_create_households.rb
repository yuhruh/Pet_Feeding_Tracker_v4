class CreateHouseholds < ActiveRecord::Migration[8.1]
  # A household is one owner's cats, food bags, litter boxes and water spots, and
  # the people the owner lets help. Every user with pets or food bags gets one, so
  # nothing changes for them: they are its owner and only person.
  def up
    create_table :households do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }, index: { unique: true }
      # nil shows as "<owner>'s cats" in the owner's language.
      t.string :name
      t.timestamps
    end

    # Caregivers and account viewers; the owner is households.owner_id, not a row here.
    create_table :household_memberships do |t|
      t.references :household, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :role, null: false
      t.timestamps
    end
    add_index :household_memberships, [ :household_id, :user_id ], unique: true

    # Litter boxes and water spots. A nil name shows as the kind's label ("Litter box").
    create_table :care_spots do |t|
      t.references :household, null: false, foreign_key: true
      t.string :kind, null: false
      t.string :name
      t.integer :position, null: false, default: 0
      t.datetime :archived_at
      t.timestamps
    end

    add_reference :pets, :household, foreign_key: true
    add_reference :dry_foods, :household, foreign_key: true

    # Plain SQL, so this keeps working however the models change later.
    execute <<~SQL
      INSERT INTO households (owner_id, created_at, updated_at)
      SELECT owners.user_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
      FROM (SELECT user_id FROM pets UNION SELECT user_id FROM dry_foods) AS owners
    SQL
    execute <<~SQL
      INSERT INTO care_spots (household_id, kind, position, created_at, updated_at)
      SELECT id, 'litter_box', 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP FROM households
    SQL
    execute <<~SQL
      INSERT INTO care_spots (household_id, kind, position, created_at, updated_at)
      SELECT id, 'water_bowl', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP FROM households
    SQL
    %w[pets dry_foods].each do |table|
      execute <<~SQL
        UPDATE #{table}
        SET household_id = (SELECT households.id FROM households WHERE households.owner_id = #{table}.user_id)
      SQL
    end

    change_column_null :pets, :household_id, false
    change_column_null :dry_foods, :household_id, false
  end

  def down
    remove_reference :dry_foods, :household, foreign_key: true
    remove_reference :pets, :household, foreign_key: true
    drop_table :care_spots
    drop_table :household_memberships
    drop_table :households
  end
end
