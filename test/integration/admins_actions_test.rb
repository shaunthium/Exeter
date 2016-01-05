require 'test_helper'
include SessionsHelper

class AdminsActionsTest < ActionDispatch::IntegrationTest
  def setup
    @timothy = users(:timothy)
    log_in_as(@timothy)
    @adam = users(:adam)
    @group_1 = groups(:group_1)
    assert_not @group_1.admins.include?(@timothy)
  end

  test "should not show add member view if not admin" do
    get new_membership_path, group_slug: @group_1.slug
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test "should not add member if not admin" do
    post memberships_path, group_slug: @group_1.slug, members: { @adam.slug => @adam.slug }
    assert_redirected_to root_path
  end

  test "should not show remove member if not admin" do
    get remove_memberships_path, group_slug: @group_1.slug
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test "should not remove member if not admin" do
    delete membership_path(id: 1), group_slug: @group_1.slug, members: { @adam.slug => @adam.slug }
    assert_redirected_to root_path
  end
end
