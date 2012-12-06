class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :remember_token

      t.boolean :admin, default: false
      t.string :account_status, default: "new"
      t.string :account_token

      t.string :name
      t.string :phone
      t.string :description

      t.timestamps
    end

    add_index  :users, :email
    add_index  :users, :remember_token

  end
end
