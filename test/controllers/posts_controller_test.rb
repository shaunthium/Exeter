require 'test_helper'

class PostsControllerTest < ActionController::TestCase
    def setup
        @user = User.new(name: "John", email: "john@hi.com", password: "1", password_confirmation: "1")
        @user.save
        @post = @user.posts.create!(content: "Test content.", group_id: 1)
    end

    test "should create new post" do
        james = users(:james)
        log_in_as(james)
        group_1 = groups(:group_1)
        post :create, post: {
            content: "Test",
            group_id: group_1.id
        }
        assert_redirected_to user_group_path(user_id: james.slug, id: group_1.slug)
    end

    test "should redirect create when not logged in" do
        assert_no_difference "Post.count" do
            post :create, post: { content: "Test" }
        end
        assert_redirected_to root_path
    end

    test "should redirect destroy when not logged in" do
        assert_no_difference "Post.count" do
            delete :destroy, id: @post
        end
        assert_redirected_to root_path
    end
end
