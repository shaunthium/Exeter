require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    @james = users(:james)
  end

  test "should redirect new if logged_in" do
    log_in_as(@james)
    get :new
    assert_redirected_to @james
  end

  test "should not be able to login with incorrect information" do
    post :create, session: {
      email: @james.email,
      password: "2"
    }
    assert_template 'new'
  end

  test "should login user with remembering" do
    post :create, session: {
      email: @james.email,
      password: "1",
      remember_me: "1"
    }
    assert_equal cookies[:remember_token], assigns[:user].remember_token
  end

  test "should login user without remembering" do
    post :create, session: {
      email: @james.email,
      password: "1",
      remember_me: "0"
    }
    assert_nil cookies[:remember_token]
  end
end
