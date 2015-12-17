require 'test_helper'

class MembershipsControllerTest < ActionController::TestCase
    def setup
        @group_2 = groups(:group_2)
        @james = users(:james)
        log_in_as(@james)
    end

    test "should create new membership" do
        assert_difference "Membership.count" do
            post :create, group_slug: @group_2.slug, members: { @james.slug => @james.slug }
            assert_not flash.empty?
            assert_redirected_to user_group_path(user_id: @james.slug, id: @group_2.slug)
        end
    end

    test "should destroy membership" do
        group_1 = groups(:group_1)
        assert_difference "Membership.count", -1 do
            post :destroy, id: group_1.slug, group_slug: group_1.slug, members: { @james.slug => @james.slug }
            assert_not flash.empty?
            assert_redirected_to user_group_path(user_id: @james.slug, id: group_1.slug)
        end
    end

end
