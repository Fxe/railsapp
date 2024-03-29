class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  has_many :microposts
  
  before_save :create_remember_token
  
  validates :name, :presence => true, :length => { :maximum => 20 }
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, 
                    :format => { :with => VALID_EMAIL_REGEX }, 
                    :uniqueness => { :case_sensitive => false }
  validates :password, :presence => true, :length => { :minimum => 6 }
  validates :password_confirmation, :presence => true
  
  def create_remember_token
    self.remember_token = SecureRandom.base64
  end
end
