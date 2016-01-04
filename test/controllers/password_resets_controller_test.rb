require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit on unauthorized access" do
    get :edit, id: 1
    assert_redirected_to root_path
  end
end
