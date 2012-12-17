class ContactsController < ApplicationController
  
  before_filter :signed_in_user, only: [:show]
  before_filter :correct_user, only: [:show]

  def show
  	@invitees = current_user.relationships
  	@inviters = current_user.reverse_relationships
  end

end
