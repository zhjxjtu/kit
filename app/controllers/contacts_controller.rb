class ContactsController < ApplicationController
  
  before_filter :signed_in_user, only: [:show]
  before_filter :correct_user, only: [:show]

  def show
  	@invitation = Invitation.new
  	@contacts = get_contacts_by_id(params[:id])
  end

end
