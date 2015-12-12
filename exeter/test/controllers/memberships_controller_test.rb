require 'test_helper'

class MembershipsControllerTest < ActionController::TestCase
    def setup
        @group_2 = groups(:group_2)
        @james = users(:james)
        log_in_as(@james)
    end

    test "should create new membership" do
        assert_difference "Membership.count" do
            post :create, group_id: @group_2, members: { @james.id => @james.id }
            assert_not flash.empty?
            assert_redirected_to user_group_path(user_id: @james, id: @group_2)
        end
    end

    test "should destroy membership" do
        group_1 = groups(:group_1)
        assert_difference "Membership.count", -1 do
            post :destroy, id: group_1, group_id: group_1, members: { @james.id => @james.id }
            assert_not flash.empty?
            assert_redirected_to user_group_path(user_id: @james, id: group_1)
        end
    end

end
