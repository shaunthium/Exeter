require 'test_helper'

class UsersPostsNotificationsTest < ActionDispatch::IntegrationTest
  def setup
    @james = users(:james)
    log_in_as(@james)
    @group_1 = groups(:group_1)
  end

  test "should notify other members of group when user posts" do
    assert_difference "Post.count" do
      assert_difference "Notification.count", 2 do
        post posts_path, post: {
          content: "Test",
          group_id: @group_1.id
        }
      end
    end
  end
end
