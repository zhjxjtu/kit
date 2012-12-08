class Invitation < ActiveRecord::Base
  attr_accessible :email, :status, :token, :user_id
  belongs_to :user

  before_save :create_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :user_id, presence: true

  private

  def create_token
    self.token = SecureRandom.urlsafe_base64
  end

end