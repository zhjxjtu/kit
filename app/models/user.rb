class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :remember_token, :account_token, :name, :phone, :description
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_tokens

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

  	def create_tokens
  	  self.remember_token = SecureRandom.urlsafe_base64
      self.account_token = SecureRandom.urlsafe_base64
    end

end
end
