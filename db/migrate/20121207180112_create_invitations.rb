class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.string :email
      t.string :token
      t.string :status, default: "new"

      t.timestamps
    end

    add_index :invitations, [:user_id, :email], unique: true
    add_index :invitations, :token

  end
end
