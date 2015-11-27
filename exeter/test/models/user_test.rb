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
      @user.posts.create!(content: "Lorem Ipsum")
      assert_difference 'Post.count', -1 do
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

  test "feed should have correct posts" do
      james = users(:james)
      michael = users(:michael)
      timothy = users(:timothy)
      james.befriend(michael)
      james.posts.each do |james_post|
          assert michael.feed.include?(james_post)
          assert_not timothy.feed.include?(james_post)
      end
      michael.posts.each do |michael_post|
          assert james.feed.include?(michael_post)
          assert_not timothy.feed.include?(michael_post)
      end
      timothy.posts.each do |timothy_post|
          assert_not james.feed.include?(timothy_post)
          assert_not michael.feed.include?(timothy_post)
      end
  end
end
