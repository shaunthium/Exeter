require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
    test "should create new group" do
        james = users(:james)
        log_in_as(james)
        get :new, id: james
        assert_difference "Group.count" do
            post :create, id: james.id, group: {
                name: "Test",
                member_id: james.id,
                group_id: 2
            }
        end
    end
end
