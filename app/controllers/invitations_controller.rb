class InvitationsController < ApplicationController
  
  def new_signup
    @user = User.new
    unless @invitation = Invitation.find_by_token(params[:token])
      flash[:error] = "Ooops...The link has expired"
      redirect_to root_path
    end
  end

  def accept_signup
    @user = User.new(params[:user])
    @invitation = Invitation.find_by_token(params[:page][:token])
    if @user.save
      create_relationship(@invitation, @user)
      @invitation.update_attribute(:status, "connected")
      sign_in(@user, params[:page][:remember_me])
      flash[:success] = "Welcome to the Focus App!"
      redirect_to root_path
    else
      flash.now[:error] = @user.errors.full_messages[0]
      render 'new'
    end
  end

  def show
  	@invitation = Invitation.new
  end

  def create
  	@invitation = Invitation.new(params[:invitation])
  	if @invitation.save
      flash[:success] = "An invitation sent to #{@invitation.email}"
      redirect_to invitation_path(current_user)
      SystemEmails.invite(@invitation).deliver
  	else
  	  flash.now[:error] = @invitation.errors.full_messages[0]
      render 'show'
  	end
  end

end
