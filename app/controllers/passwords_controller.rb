class PasswordsController < ApplicationController
  
  before_filter :signed_in_user, only: [:show, :update]
  before_filter :myself_or_admin_user, only: [:show, :update]

  def new
    @user = User.new
  end

  def create
    if User.exists?(email: params[:user][:email])
      @user = User.find_by_email(params[:user][:email])
      flash[:notice] = "An email with the link to reset your password has been sent to #{params[:user][:email]}"
      redirect_to signin_path
      # Delayed jobs: SystemEmails.delay.reset_password(@user)
      SystemEmails.reset_password(@user).deliver
    else
      @user = User.new
      flash.now[:error] = "Invalid or wrong email"
      render 'new'
    end
  end

  def reset_new
    unless @user = User.find_by_account_token(params[:account_token])
      flash[:error] = "Ooops...The link has expired"
      redirect_to root_path
    end
  end

  def reset_update
    @user = User.find_by_account_token(params[:user][:account_token])
    if @user.update_attributes(params[:user])
      flash[:success] = "Please sign in with your new password"
      redirect_to signin_path
    else
      flash[:error] = @user.errors.full_messages[0]
      redirect_to reset_new_path + "?account_token=#{@user.account_token}"
    end
  end

  def edit
  	@user = User.find(params[:id])
    @invitation = Invitation.new
  end

  def update
  	@user = User.find(params[:id])
    if !@user.authenticate(params[:page][:password])
      flash.now[:error] = "Old password is not correct"
      render 'edit'
    elsif @user.update_attributes(params[:user])
      flash[:success] = "Password updated"
      sign_in(@user,"yes")
      redirect_to contacts_path
    else
      flash.now[:error] = @user.errors.full_messages[0]
      render 'edit'
    end
  end

end
