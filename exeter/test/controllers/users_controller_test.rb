require 'test_helper'

class UsersControllerTest < ActionController::TestCase
    def setup
        @user_params = {
            user: {
                name: "John",
                email: "john@example.com",
                password: "1",
                password_confirmation: "1"
            }
        }
    end

    test "should create user" do
        assert_difference "User.count" do
            post :create, @user_params
        end
    end

    test "should update user's information" do
        james = users(:james)
        log_in_as(james)
        post :update, id: james, user: {
            name: "Sam",
            email: "test@test.com",
            password: "1",
            password_confirmation: "1"
        }
        assert_not flash.empty?
        assert_redirected_to james
    end
end
