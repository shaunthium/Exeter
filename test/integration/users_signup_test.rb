require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
    test "invalid signup information" do
        get root_path
        assert_no_difference 'User.count' do
            post users_path, user: {
                name: "James Lim",
                email: " ",
                password: "1",
                password_confirmation: "1"
            }
        end
        assert_template 'users/new'
    end
end
