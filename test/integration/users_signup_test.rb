require 'test_helper'
include SessionsHelper

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get root_path
    assert_no_difference 'User.count' do
      post users_path, user: {
        name: "James Lim",
        email: " ",
        password: "1",
        password_confirmation: "1"
      }
    end
    assert_template 'users/new'
  end

  test "valid signup information with account activation" do
    post users_path, user: {
      name: "James Lim",
      email: "james@test.com",
      password: "1",
      password_confirmation: "1"
    }

    new_user = assigns(:user)
    assert_not new_user.activated?

    log_in_as(new_user)
    assert_not is_logged_in?

    get verify_account_path("invalid")
    assert_not is_logged_in?

    get verify_account_path(new_user.activation_token, email: "invalid@example.com")
    assert_not is_logged_in?

    get verify_account_path(new_user.activation_token, email: new_user.email)
    # Need to reload user from database as attribute has changed
    assert new_user.reload.activated?
  end
end
