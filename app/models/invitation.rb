class Invitation < ActiveRecord::Base
  attr_accessible :email, :status, :token, :user_id
end
