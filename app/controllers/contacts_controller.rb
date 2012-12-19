class ContactsController < ApplicationController
  
  before_filter :signed_in_user, only: [:show]
  before_filter :correct_user, only: [:show]

  def show
  	@contacts = get_contacts (current_user)
  end

end
