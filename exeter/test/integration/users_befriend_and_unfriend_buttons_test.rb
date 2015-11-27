require 'test_helper'

class UsersBefriendAndUnfriendButtonsTest < ActionDispatch::IntegrationTest
    test "should show befriend button when users are not friends" do
        log_in_as(users(:james))
        get user_path(users(:michael))
        assert_select "#submit-btn" do
            assert_select "[value=?]", "Befriend"
        end
    end

    test "should show unfriend button when users are friends" do
        james = users(:james)
        michael = users(:michael)
        james.befriend(michael)
        log_in_as(james)
        get user_path(michael)
        assert_select "#submit-btn" do
            assert_select "[value=?]", "Unfriend"
        end
    end
end
