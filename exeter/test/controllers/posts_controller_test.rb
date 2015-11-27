require 'test_helper'

class PostsControllerTest < ActionController::TestCase
    def setup
        @user = User.new(name: "John", email: "john@hi.com", password: "1", password_confirmation: "1")
        @user.save
        @post = @user.posts.create!(content: "Test content.")
    end

    test "should redirect create when not logged in" do
        assert_no_difference "Post.count" do
            post :create, post: { content: "Test" }
        end
        assert_redirected_to root_url
    end

    test "should redirect destroy when not logged in" do
        assert_no_difference "Post.count" do
            delete :destroy, id: @post
        end
        assert_redirected_to root_url
    end
end
