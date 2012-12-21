module ApplicationHelper
  
  # All the before filters listed here --------------------

  def unsigned_in_user
  	redirect_to contact_path(current_user) unless current_user.nil?
  end
  
  def signed_in_user
  	unless signed_in?
  	  store_location
	    flash[:notice] = "Please sign in."
	    redirect_to signin_path
	  end
  end

  def myself_or_admin_user
    unless myself? || admin?
      redirect_to contact_path(current_user)
    end
  end

  def users_show_authorized_user
    unless myself? || invited? || connected? || admin?
      redirect_to contact_path(current_user)
    end
  end

  def admin_user
  	unless admin?
  	  redirect_to contact_path(current_user)
  	end
  end 

  # Sessions related --------------------

  def sign_in(user, remember_me)
  	if remember_me == "yes"
  	  cookies.permanent[:remember_token] = user.remember_token
  	else
  	  cookies[:remember_token] = user.remember_token
  	end
  	self.current_user = user
  end

  def current_user=(user)
  	@current_user = user
  end

  def current_user
  	@current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def store_location
    session[:return_to] = request.url
  end

  def redirect_back_or(default)
  	redirect_to(session[:return_to] || default)
  	session.delete(:return_to)
  end

  def signed_in?
    !current_user.nil?
  end

  # Users related --------------------

  def update_without_password(user, params)
  	user.update_attribute(:name, params[:name])&&user.update_attribute(:phone, params[:phone])&&user.update_attribute(:description, params[:description])
  end
  
  def myself?
    current_user == User.find(params[:id])
  end

  def invited?
    User.find(params[:id]).invitations.exists?(email: current_user.email)
  end

  def connected?
    current_user.invitees.exists?(params[:id]) || current_user.inviters.exists?(params[:id])
  end

  def admin?
    current_user.admin == true
  end

  # Invitations related --------------------

  def create_relationship(invitation, user)
  	relationship = Relationship.new(invitation_id: invitation.id, inviter_id: invitation.user_id, invitee_id: user.id)
  	relationship.save
  	invitation.update_attribute(:status, "connected")
  end

  def add_self?(email)
    email == current_user.email
  end

  def current_contact_by_email?(email)
    if user = User.find_by_email(email)
      current_user.invitees.exists?(user.id) || current_user.inviters.exists?(user.id)
    end
  end

  def already_invited_by?(email)
    if user = User.find_by_email(email)
      user.invitations.exists?(user_id: user.id, email: current_user.email)
    end
  end

  def accept_original_invitation(invitation)
    original_inviter = User.find_by_email(invitation.email)
    original_invitation = Invitation.find_by_user_id_and_email(original_inviter.id, current_user.email)
    create_relationship(original_invitation, current_user)
  end

  def existing_invitation_to?(email)
    current_user.invitations.exists?(email: email)
  end

  def send_invitation(invitation)
    # Delayed jobs: SystemEmails.delay.invite(@invitation)
    SystemEmails.invite(invitation).deliver unless User.exists?(email: invitation.email)
  end

  # Contacts related --------------------

  def get_contacts_by_id(id)
    user = User.find(id)
    user.invitees + user.inviters
  end

  def get_contacts_by_user(user)
    user.invitees + user.inviters
  end

end