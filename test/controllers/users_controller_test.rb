require 'test_helper'

class UsersControllerTest < ActionController::TestCase
    def setup
        @james = users(:james)
        log_in_as(@james)
    end

    test "should create user" do
        assert_difference "User.count" do
            post :create, user: {
                            name: "John",
                            email: "john@example.com",
                            password: "1",
                            password_confirmation: "1"
                          }
        end
    end

    test "should update user's information" do
        post :update, id: @james, user: {
            name: "Sam",
            email: "test@test.com",
            password: "1",
            password_confirmation: "1"
        }
        assert_not flash.empty?
        assert_redirected_to "/users/sam"
    end

    test "should delete user and associated friends" do
        @james.befriend(users(:michael))
        assert_difference "User.count", -1 do
            assert_difference "Friendship.count", -2 do
                post :destroy, id: @james
            end
        end
    end
end
