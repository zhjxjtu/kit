class Relationship < ActiveRecord::Base
  attr_accessible :invitation_id, :invitee_id, :inviter_id
  belongs_to :inviter, class_name: "User"
  belongs_to :invitee, class_name: "User"
  belongs_to :invitation

  validates :inviter_id, presence: true
  validates :invitee_id, presence: true
  validates :invitation_id, presence: true
end
