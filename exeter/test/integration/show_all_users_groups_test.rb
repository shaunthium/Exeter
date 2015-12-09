require 'test_helper'

class ShowAllUsersGroupsTest < ActionDispatch::IntegrationTest
    test "should show all user's groups" do
        @james = users(:james)
        first = groups(:first)
        second = groups(:second)
        first.member_id = @james.id
        second.member_id = @james.id
        log_in_as(@james)
        get user_path(id: @james)
        assert_not @groups.nil?
        assert_template 'users/show'
        assert_select "ol#groups-ol" do
            assert_select "li", 2
        end
    end
end
