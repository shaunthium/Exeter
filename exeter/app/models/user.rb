class User < ActiveRecord::Base
    include UsersHelper
    has_many :posts, dependent: :destroy
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships
    has_many :memberships, foreign_key: "member_id",
                            dependent: :destroy
    has_many :groups, through: :memberships

    has_secure_password

    before_save { self.email = email.downcase }

    validates :name, presence: true, length: { minimum: 1 }
    validates :password, length: { minimum: 1 }
    validates :email, presence: true, uniqueness: { case_sensitive: false }
end
