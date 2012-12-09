module InvitationsHelper
  def create_relationship (invitation, user)
  	relationship = Relationship.new(invitation_id: invitation.id, inviter_id: invitation.user_id, invitee_id: user.id)
  	relationship.save
  	invitation.update_attribute(:status, "connected")
  end
end
