class AddIndexToInvitationsEmail < ActiveRecord::Migration
  def change
  	add_index :invitations, :email
  end
end