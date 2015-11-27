require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
    test "should show user after login" do
        user = users(:james)
        log_in_as(user)
        get user_path(user)
        assert_select 'title', "Exeter | #{user.name}"
    end
end
