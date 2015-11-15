require 'test_helper'

class PostTest < ActiveSupport::TestCase
    def setup
        @user = users(:james)
        @post = @user.posts.build(content: "Test content.")
    end

    test "should be valid" do
        assert @post.valid?
    end

    test "user id should be present" do
        @post.user_id = nil
        assert_not @post.valid?
    end

    test "content should be present" do
        @post.content = "     "
        assert_not @post.valid?
    end

    test "posts should be in descending order" do
        assert_equal posts(:most_recent), Post.first
    end
end
