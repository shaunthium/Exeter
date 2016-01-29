class Notification < ActiveRecord::Base
  belongs_to :user

  # Sorts notifications by descending order of creation (i.e. latest notification first)
  default_scope -> { order(created_at: :desc) }

  validates :content, presence: true
end
