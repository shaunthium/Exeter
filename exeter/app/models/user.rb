class User < ActiveRecord::Base
  has_secure_password
  before_save { self.email = email.downcase }
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
