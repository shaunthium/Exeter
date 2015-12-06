class Group < ActiveRecord::Base
    self.primary_key = "group_id"

    validates :name, presence: true
    validates :member_id, presence: true
    validates :group_id, presence: true
end
