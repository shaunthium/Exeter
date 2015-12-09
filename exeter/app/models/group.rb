class Group < ActiveRecord::Base
    has_many :memberships, dependent: :destroy
    has_many :members, class_name: "User", through: :memberships

    validates :name, presence: true
end
