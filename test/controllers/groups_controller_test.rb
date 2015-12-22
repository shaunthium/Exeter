require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
    def setup
        @group_1 = groups(:group_1)
        @james = users(:james)
        log_in_as(@james)
    end

    test "should create new group" do
        assert_difference "Group.count" do
            post :create, user_id: @james.slug, group: {
                name: "Test"
            }
        end
    end

    test "should show group members" do
        get :show, user_id: @james.slug, id: @group_1.slug
        assert_select 'div#group-members' do
            assert_select "li", 2
        end
    end

    test "should update group information" do
        post :update, user_id: @james.slug, id: @group_1.slug, group: { name: "New group name" }
        assert_not flash.empty?
        assert_redirected_to user_group_path(user_id: @james.slug, id: "New group name".parameterize)
    end

    test "should destroy group" do
        assert_difference "Group.count", -1 do
            post :destroy, user_id: @james.slug, id: @group_1.slug
            assert_not flash.empty?
            assert_redirected_to user_path(@james.slug)
        end
    end
end
