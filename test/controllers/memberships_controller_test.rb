require 'test_helper'
include MembershipsHelper, SessionsHelper

class MembershipsControllerTest < ActionController::TestCase
  def setup
    @group_1 = groups(:group_1)
    @james = users(:james)
    log_in_as(@james)
    @adam = users(:adam)
    @michael = users(:michael)
  end

  test "should create new membership" do
    assert_difference "Membership.count" do
      post :create, group_slug: @group_1.slug, members: { @michael.name => @michael.slug }
      assert_not flash.empty?
      assert_redirected_to user_group_path(user_id: @james.slug, id: @group_1.slug)
    end
  end

  test "should destroy membership" do
    assert_difference "Membership.count", -1 do
      post :destroy, id: @group_1.slug, group_slug: @group_1.slug, members: { @adam.slug => @adam.slug }
      assert_not flash.empty?
      assert_redirected_to user_group_path(user_id: @james.slug, id: @group_1.slug)
    end
  end
end
