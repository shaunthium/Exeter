class Membership < ActiveRecord::Base
  belongs_to :member, class_name: "User"
  belongs_to :group

  validates :member_id, presence: true
  validates :group_id, presence: true
end
