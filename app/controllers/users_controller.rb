class UsersController < ApplicationController

  # filter of show should be contacts user, to be developed
  before_filter :signed_in_user, only: [:index, :edit, :update, :show]
  before_filter :correct_user, only: [:edit, :update, :show]
  before_filter :admin_user, only: [:index]

  def index
    @users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in(@user, params[:page][:remember_me])
      flash[:success] = "Welcome to the JingsApp!"
      redirect_to contact_path(current_user)
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
      redirect_to contact_path(current_user)
    else
      flash.now[:error] = @user.errors.full_messages[0]
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
