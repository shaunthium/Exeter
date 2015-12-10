require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
    def setup
        @james = users(:james)
        log_in_as(@james)
    end

    test "should create new group" do
        get :new, user_id: @james
        assert_difference "Group.count" do
            post :create, user_id: @james, group: {
                name: "Test"
            }
        end
    end
end
