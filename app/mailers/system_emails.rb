class SystemEmails < ActionMailer::Base
  
  default from: "Focus Project Team <focustest.2012@gmail.com>"

  def invite(invitation)
  	@invitation = invitation
  	mail to: @invitation.email, from: @invitation.user.name, subject: "Hi, may I have your contact information please?"
  end

  def reset_password(user)
  	@user = user
  	mail to: @user.email, subject: "Keep in Touch: Reset Password"
  end
end
