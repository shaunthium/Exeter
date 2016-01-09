require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  def setup
    @post_james_group_1 = posts(:post_james_group_1)
    @james = users(:james)
    @group_1 = groups(:group_1)
  end

  test "should create new post" do
    log_in_as(@james)
    assert_difference "Post.count" do
      post :create, post: {
        content: "Test",
        group_id: @group_1.id
      }
    end
    assert_redirected_to user_group_path(user_id: @james.slug, id: @group_1.slug)
  end

  test "should delete post" do
    log_in_as(@james)
    assert_difference "Post.count", -1 do
      post :destroy, id: @post_james_group_1.id, group_id: @group_1.id, group_slug: @group_1.slug
      assert_not flash.empty?
      assert_redirected_to user_group_path(user_id: @james.slug, id: @group_1.slug)
    end
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Post.count" do
      post :create, post: { content: "Test" }
    end
    assert_redirected_to root_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Post.count" do
      delete :destroy, id: @post_james_group_1.id
    end
    assert_redirected_to root_path
  end
end
