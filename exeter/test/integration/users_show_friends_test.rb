require 'test_helper'

class UsersShowFriendsTest < ActionDispatch::IntegrationTest
    test "should show friends of user" do
        james = users(:james)
        michael = users(:michael)
        log_in_as(james)
        get user_friends_path(user_id: james.id)
        # 1 "li" already present as logout button
        # in navbar
        assert_select "li", count: 1
        james.befriend(michael)
        get user_friends_path(user_id: james.id)
        assert_select "li", count: 2
    end
end
