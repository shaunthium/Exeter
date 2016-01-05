require 'test_helper'

class UsersAddFriendsToGroupTest < ActionDispatch::IntegrationTest
  test "should add friend to group" do
    james = users(:james)
    group_2 = groups(:group_2)
    assert_difference "Membership.count" do
      james.memberships.create(group_id: group_2.id)
    end
  end
end
