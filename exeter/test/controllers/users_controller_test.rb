require 'test_helper'

class UsersControllerTest < ActionController::TestCase
    def setup
        @test = {
            user: {
                name: "Test",
                email: "test@tsest.com",
                password: "1",
                password_confirmation: "2"
            }
        }
    end

    test "creation of user" do
        post :create, @test
    end

    test "should show all user's groups" do
        first_group = groups(:one)
        second_group = groups(:two)
        james = users(:james)
        log_in_as(james)
        get :show, id: james.id
        assert_template 'users/show'
        assert_select "ol#groups-ol" do
            assert_select "li", 2
        end
    end
end
