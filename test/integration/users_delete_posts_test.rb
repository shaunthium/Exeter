require 'test_helper'

class UsersDeletePostsTest < ActionDispatch::IntegrationTest
  test "should redirect destroy for attempted unauthorized deletion of post" do
    user = users(:james)
    log_in_as(user)
    post = posts(:most_recent)
    assert_no_difference "Post.count" do
      delete post_path(post.id)
    end
  end
end
