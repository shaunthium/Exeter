class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :content, presence: true

  # Sorts posts by descending order of creation (i.e. latest post first)
  default_scope -> { order(created_at: :desc) }
end
