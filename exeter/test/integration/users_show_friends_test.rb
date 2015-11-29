require 'test_helper'

class UsersShowFriendsTest < ActionDispatch::IntegrationTest
    test "should show friends of user" do
        james = users(:james)
        michael = users(:michael)
        log_in_as(james)
        get friends_user_path(james.id)
        # 1 "li" already present as logout button
        # in navbar
        assert_select "li", count: 1
        james.befriend(michael)
        get friends_user_path(james.id)
        assert_select "li", count: 2
    end
end
