require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
    test "should show user after login" do
        james = users(:james)
        log_in_as(james)
        get user_path(james)
        assert_select 'title', "Exeter | #{james.name}"
    end
end
