require 'test_helper'

class UsersPostTest < ActionDispatch::IntegrationTest
    def setup
        @user = User.new(name: "John", email: "john@hi.com", password: "1", password_confirmation: "1")
        @user.save
        @post = @user.posts.build(content: "Test content.")
    end

    test "user's post should show up on page" do
        @user.posts.create!(content: "Lorem Ipsum")
        post_via_redirect login_path, session: { email: @user.email, password: "1" }
        assert_select "ol.posts"
    end

end
