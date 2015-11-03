class User < ActiveRecord::Base
  has_secure_password
  before_save { self.email = email.downcase }
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
