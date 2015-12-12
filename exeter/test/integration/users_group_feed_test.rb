require 'test_helper'

class UsersGroupFeedTest < ActionDispatch::IntegrationTest
    test "should show user's feed when visiting group" do
        james = users(:james)
        michael = users(:michael)
        james.befriend(michael)
    end
end
