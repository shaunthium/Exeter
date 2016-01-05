module Friendable
  extend ActiveSupport::Concern

  included do
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships
  end

  # Befriends other User
  def befriend(other_user)
    self.friendships.create!(friend_id: other_user.id)
    other_user.friendships.create!(friend_id: id)
  end

  # Unfriends other User
  def unfriend(other_user)
    self.friendships.find_by(friend_id: other_user.id).destroy!
    other_user.friendships.find_by(friend_id: id).destroy!
  end

  # Returns true if user is friends with other User
  def is_friends_with?(other_user)
    self.friends.include?(other_user)
  end
end
