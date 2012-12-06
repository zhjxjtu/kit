class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :remember_token
end
