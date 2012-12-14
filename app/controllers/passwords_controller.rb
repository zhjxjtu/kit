class PasswordsController < ApplicationController
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
