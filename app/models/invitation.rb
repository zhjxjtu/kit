class Invitation < ActiveRecord::Base
  attr_accessible :email, :status, :token, :user_id
  belongs_to :user
end