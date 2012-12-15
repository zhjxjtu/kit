class PasswordsController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new
    if User.exists?(email: params[:user][:email])
      @user = User.find_by_email(params[:user][:email])
      flash[:notice] = "An email with the link to reset your password has been sent to #{params[:user][:email]}"
      redirect_to signin_path
      SystemEmails.reset_password(@user).deliver
    else
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
    
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Password updated"
      sign_in(@user,"yes")
      redirect_to root_path
    else
      flash.now[:error] = @user.errors.full_messages[0]
      render 'edit'
    end
  end

end
