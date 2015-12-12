class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :content, presence: true
  default_scope -> { order(created_at: :desc) }
end
