class Adminship < ActiveRecord::Base
    belongs_to :admin, class_name: "User"
    belongs_to :administrated_group, class_name: "Group"

    validates :admin_id, presence: true
    validates :administrated_group_id, presence: true
end
