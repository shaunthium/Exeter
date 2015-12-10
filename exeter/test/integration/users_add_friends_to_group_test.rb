require 'test_helper'

class UsersAddFriendsToGroupTest < ActionDispatch::IntegrationTest
    test "should add friend to group" do
        james = users(:james)
        group_1 = groups(:group_1)
        assert_difference "Membership.count" do
            james.memberships.create(group_id: group_1.id)
        end
    end
end
