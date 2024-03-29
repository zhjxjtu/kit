class SessionsController < ApplicationController

  def new
	
  end

  def create
  	user = User.find_by_email(params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		sign_in(user, params[:remember_me])
		  redirect_to contacts_path
	  else
		  flash.now[:error] = 'Invalid email or password'
		  render 'new'
	  end
  end

  def destroy
  	sign_out
	  redirect_to root_path
  end
end
