require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    james = users(:james)
    group_1 = groups(:group_1)
    @post = james.posts.build(content: "Test content.", group_id: group_1.id)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "group id should be present" do
    @post.group_id = nil
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content = "     "
    assert_not @post.valid?
  end

  test "posts should be in descending order" do
    assert_equal Post.first, posts(:most_recent)
  end
end
