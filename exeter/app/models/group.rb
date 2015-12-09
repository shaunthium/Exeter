class Group < ActiveRecord::Base
    belongs_to :user

    validates :name, presence: true
    validates :member_id, presence: true
    validates :group_id, presence: true
end
