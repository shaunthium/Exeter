require 'test_helper'

class ShowAllUsersGroupsTest < ActionDispatch::IntegrationTest
    test "should show all user's groups" do
        james = users(:james)
        group_1 = groups(:group_1)
        james.memberships.create(group_id: group_1.id)
        log_in_as(james)
        get user_path(id: james)
        assert_template 'users/show'
        assert_select "ol#groups-ol" do
            assert_select "li", 1
        end
    end
end
