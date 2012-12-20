class AddInfoColumnsToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :name, :string
    add_column :invitations, :phone, :string
    add_column :invitations, :description, :string
    add_column :invitations, :message, :string
  end
end
