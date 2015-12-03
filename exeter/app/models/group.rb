class Group < ActiveRecord::Base
    self.primary_key = "group_id"

    validates :name, presence: true
end
