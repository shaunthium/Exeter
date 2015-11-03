class User < ActiveRecord::Base
  has_secure_password
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { minimum: 1 }
  validates :password, length: { minimum: 6 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
