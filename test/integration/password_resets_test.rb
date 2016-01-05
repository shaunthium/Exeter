require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @james = users(:james)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template "password_resets/new"
    # Invalid email
    post password_resets_path, password_reset: {
      email: "  "
    }
    assert_not flash.empty?
    assert_template "password_resets/new"
    # Valid email
    post password_resets_path, password_reset: {
      email: @james.email
    }
    assert_not_equal @james.reset_digest, @james.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_path
    # Use assigns to access virtual attribute (reset_token)
    james = assigns(:user)
    # Wrong email
    get edit_password_reset_path(james.reset_token, email: " ")
    assert_redirected_to root_path
    # Inactive user
    james.toggle!(:activated)
    get edit_password_reset_path(james.reset_token, email: james.email)
    assert_redirected_to root_path
    james.toggle!(:activated)
    # Right email, wrong token
    get edit_password_reset_path("wrong token", email: james.email)
    assert_redirected_to root_path
    # Right email, right token
    get edit_password_reset_path(james.reset_token, email: james.email)
    assert_template "password_resets/edit"
    # Invalid password & password confirmation
    patch password_reset_path(james.reset_token),
    email: james.email,
    user: {
      password: "invalid",
      password_confirmation: "invalid too"
    }
    assert_select 'div#error_messages'
    # Empty password
    patch password_reset_path(james.reset_token), email: james.email,
    user: {
      password: "",
      password_confirmation: ""
    }
    assert_select 'div#error_messages'
    # Valid password & password confirmation
    patch password_reset_path(james.reset_token), email: james.email,
    user: {
      password: "1",
      password_confirmation: "1"
    }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to james
  end
end
