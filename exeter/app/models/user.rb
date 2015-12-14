class User < ActiveRecord::Base
    # Needed to allow User instances
    # to call methods in UsersHelper
    include UsersHelper

    extend FriendlyId
    friendly_id :name, use: :slugged

    has_many :posts, dependent: :destroy
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships
    has_many :memberships, foreign_key: "member_id",
                            dependent: :destroy
    has_many :groups, through: :memberships

    has_secure_password

    before_save { self.email = email.downcase }

    # More validations for name, email and password length
    # to be included before pushing to Production
    validates :name, presence: true, length: { minimum: 1 }
    validates :password, length: { minimum: 1 }
    validates :email, presence: true, uniqueness: { case_sensitive: false }
end
