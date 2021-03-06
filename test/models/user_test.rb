require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example", email: "john@example.com", password: "123", password_confirmation: "123")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "user's name should not be empty" do
    @user.name = '    '
    assert_not @user.valid?
  end

  test "user's email should not be empty" do
    @user.email = '    '
    assert_not @user.valid?
  end

  test "user's email should be unique, regardless of case" do
    duplicate_user = @user.dup
    @user.save
    duplicate_user.email = @user.email.upcase
    assert_not duplicate_user.valid?
  end

  test "associated user post should be deleted" do
      @user.save
      @user.posts.create!(content: "Lorem Ipsum", group_id: 1)
      assert_difference "Post.count", -1 do
          @user.destroy
      end
  end

  test "associated user's friendships should be deleted" do
      @user.save
      michael = users(:michael)
      assert_difference "Friendship.count", 2 do
          @user.befriend(michael)
      end
      assert_difference "Friendship.count", -1 do
          @user.destroy
      end
  end

  test "associated user's memberships should be deleted" do
      @user.save
      assert_difference "Membership.count" do
          @user.add_to_group(groups(:group_2))
      end
      assert_difference "Membership.count", -1 do
          @user.destroy
      end
  end

  test "should befriend and unfriend another user" do
      @james = users(:james)
      @michael = users(:michael)
      assert_not @james.is_friends_with?(@michael)
      @james.befriend(@michael)
      assert @james.is_friends_with?(@michael)
      assert @michael.is_friends_with?(@james)
  end
end
