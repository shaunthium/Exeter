class Group < ActiveRecord::Base
    validates :name, presence: true
    validates :member_id, presence: true
    validates :group_id, presence: true
end
