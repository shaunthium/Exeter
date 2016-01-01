require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: 1
    assert_response :success
  end
end
