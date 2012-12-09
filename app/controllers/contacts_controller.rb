class ContactsController < ApplicationController
  
  def show
  	@invitees = current_user.relationships
  	@inviters = current_user.reverse_relationships
  end

end
