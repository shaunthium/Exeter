require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase
    def setup
        @james = users(:james)
        log_in_as(@james)
        @michael = users(:michael)
    end

    test "should create new friendship" do
        assert_not @james.is_friends_with?(@michael)
        post :create, friend_id: @michael.id
        assert @james.is_friends_with?(@michael)
        assert_redirected_to @james
    end

    test "should destroy friendship" do
        @james.befriend(@michael)
        assert @james.is_friends_with?(@michael)
        friendship = @james.friendships.find_by(friend_id: @michael.id)
        post :destroy, id: friendship.id
        assert_not @james.is_friends_with?(@michael)
        assert_redirected_to @james
    end
end
