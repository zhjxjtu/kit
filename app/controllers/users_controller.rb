class UsersController < ApplicationController

  # filter of show should be contacts user, to be developed
  before_filter :signed_in_user, only: [:index, :update, :show, :destroy]
  before_filter :myself_or_admin_user, only: [:update]
  before_filter :users_show_authorized_user, only: [:show]
  before_filter :admin_user, only: [:index, :destroy]

  def index
    @users = User.all
    @invitation = Invitation.new
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in(@user, params[:page][:remember_me])
      flash[:success] = "Welcome to JingsApp!"
      redirect_to contact_path(current_user)
  	else
  	  flash.now[:error] = @user.errors.full_messages[0]
      render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
    @invitation = Invitation.new
  end

  def update
    @user = User.find(params[:id])
    if update_without_password(@user, params[:user])
      flash[:success] = "Profile updated"
      sign_in(@user,"yes")
      redirect_to user_path(current_user)
    else
      flash.now[:error] = @user.errors.full_messages[0]
      redirect_to user_path(current_user)
    end
  end

  def show
    @user = User.find(params[:id])
    @invitation = Invitation.new
  end

  def destroy
    user = User.find(params[:id])
    flash[:success] = "User #{user.email} destroyed."
    user.destroy
    redirect_to users_path
  end
end
