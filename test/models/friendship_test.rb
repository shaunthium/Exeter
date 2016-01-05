require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def setup
    @friendship = Friendship.new(user_id: 1, friend_id: 1)
  end

  test "should be valid" do
    assert @friendship.valid?
  end

  test "should require friend_id" do
    @friendship.friend_id = nil
    assert_not @friendship.valid?
  end

  test "should require user_id" do
    @friendship.user_id = nil
    assert_not @friendship.valid?
  end
end
