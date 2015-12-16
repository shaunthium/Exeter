class Group < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: :slugged
    
    has_many :posts, dependent: :destroy
    has_many :memberships, dependent: :destroy
    has_many :members, class_name: "User", through: :memberships

    validates :name, presence: true
end
