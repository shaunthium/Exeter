require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
    test "should get new" do
        get :new
        assert_response :success
    end

    test "should redirect new if logged_in" do
        user = users(:james)
        log_in_as(user)
        get :new
        assert_redirected_to user
    end

    test "should not be able to login with incorrect information" do
      user = User.create(name: "Test", email: "test@test.com", password: "1", password_confirmation: "1")
      post :create, session: {
          email: "test@test.com",
          password: "2"
      }
      assert_template 'new'
    end
end
