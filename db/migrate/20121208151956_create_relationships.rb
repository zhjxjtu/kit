class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :inviter_id
      t.integer :invitee_id
      t.integer :invitation_id

      t.timestamps
    end

    add_index :relationships, [:inviter_id, :invitee_id], unique: true
    add_index :relationships, :invitation_id, unique: true

  end
end
