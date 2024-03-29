class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, 
                  :remember_token, :account_token, :name, :phone, :description
  has_secure_password

  has_many :invitations, dependent: :destroy
  has_many :relationships, foreign_key: "inviter_id", dependent: :destroy
  has_many :invitees, through: :relationships, source: :invitee
  has_many :reverse_relationships, foreign_key: "invitee_id", class_name: "Relationship", dependent: :destroy
  has_many :inviters, through: :reverse_relationships, source: :inviter

  before_save { |user| user.email = email.downcase }
  before_save :create_tokens

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :name, presence: true, length: { minimum: 2 }

  private

  	def create_tokens
  	  self.remember_token = SecureRandom.urlsafe_base64
      self.account_token = SecureRandom.urlsafe_base64
    end

end
