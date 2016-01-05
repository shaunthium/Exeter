class Group < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :posts, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :members, class_name: "User", through: :memberships
  has_many :adminships, foreign_key: "administrated_group_id", dependent: :destroy
  has_many :admins, class_name: "User", through: :adminships

  validates :name, presence: true
end
