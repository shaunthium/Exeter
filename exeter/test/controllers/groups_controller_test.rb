require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
    def setup
        @james = users(:james)
        log_in_as(@james)
    end
    test "should create new group" do
        get :new, user_id: @james.id
        assert_difference "Group.count" do
            post :create, user_id: @james.id, group: {
                name: "Test"
            }
        end
    end

    test "should add friend to group" do

    end
end
