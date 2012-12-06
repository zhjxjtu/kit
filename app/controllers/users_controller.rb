class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      #sign_in(@user, params[:remember_me])
      #flash[:success] = "Welcome to the Focus App!"
      redirect_to root_path
  	else
  	  #flash[:error] = @user.errors.full_messages[0]
      redirect_to signup_path
  	end
  end

end
