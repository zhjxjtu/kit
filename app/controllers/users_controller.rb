class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in(@user, params[:page][:remember_me])
      flash[:success] = "Welcome to the Focus App!"
      redirect_to root_path
  	else
  	  flash.now[:error] = @user.errors.full_messages[0]
      render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if update_without_password(@user, params[:user])
      flash[:success] = "Profile updated"
      sign_in(@user,"yes")
      redirect_to root_path
    else
      flash.now[:error] = @user.errors.full_messages[0]
      render 'edit'
    end
  end

end
