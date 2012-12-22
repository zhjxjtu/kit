class InvitationsController < ApplicationController
  
  # Invitations' filter to be set

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
      sign_in(@user, params[:page][:remember_me])
      flash[:success] = "Your infomation has been sent back to #{@invitation.user.name}"
      redirect_to contacts_path
    else
      flash[:error] = @user.errors.full_messages[0]
      redirect_to invitations_new_signup_path + "?token=#{params[:page][:token]}"
    end
  end

  def new_signin
    unless @invitation = Invitation.find_by_token(params[:token])
      flash[:error] = "Ooops...The link has expired"
      redirect_to root_path
    end
  end

  def accept_signin
    user = User.find_by_email(params[:session][:email].downcase)
    invitation = Invitation.find_by_token(params[:page][:token])
    if user && user.authenticate(params[:session][:password])
      create_relationship(invitation, user)
      sign_in(user, params[:remember_me])
      flash[:success] = "You are now connected with " + invitation.user.name
      redirect_to contacts_path
    else
      flash[:error] = 'Invalid email or password'
      redirect_to invitations_new_signin_path + "?token=#{params[:page][:token]}"
    end
  end

  def index
    @invitation = Invitation.new    
    @received_invitations = Invitation.where("email = ? AND status = ?", current_user.email, "new")
    @sent_invitations = current_user.invitations.where("status = ?", "new")
  end

  def create
  	@invitation = Invitation.new(params[:invitation])
    @invitation.email = @invitation.email.downcase
  	if add_self?(@invitation.email)
      flash[:error] = "You can't add yourself"
      redirect_to contacts_path
    elsif current_contact_by_email?(@invitation.email)
      flash[:notice] = "You already have the information of " + User.find_by_email(@invitation.email).name + " (#{@invitation.email})"
      redirect_to contacts_path
    elsif already_invited_by?(@invitation.email)
      accept_original_invitation(@invitation)
      flash[:notice] = "You are now connected with" + User.find_by_email(@invitation.email).name + " (#{@invitation.email})"
      redirect_to contacts_path
    elsif existing_invitation_to?(@invitation.email)
      flash[:success] = "An reminding email sent to #{@invitation.email}"
      redirect_to invitations_path
      send_invitation(@invitation)
    elsif @invitation.save
      flash[:success] = "An invitation sent to #{@invitation.email}"
      redirect_to invitations_path
      send_invitation(@invitation)
  	else
  	  flash[:error] = @invitation.errors.full_messages[0]
      redirect_to invitations_path
  	end
  end

end
