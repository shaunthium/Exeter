require 'test_helper'

class UsersControllerTest < ActionController::TestCase
    def setup
        @test = {
            user: {
                name: "Test",
                email: "test@tsest.com",
                password: "1",
                password_confirmation: "1"
            }
        }
    end

    test "creation of user" do
        post :create, @test
    end
end
