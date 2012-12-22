class ContactsController < ApplicationController
  
  before_filter :signed_in_user, only: [:index]
  before_filter :myself_or_admin_user, only: [:show]

  def index
  	@invitation = Invitation.new
  	@contacts = get_contacts_by_user(current_user)
  end

end
