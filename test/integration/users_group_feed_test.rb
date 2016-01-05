require 'test_helper'

class UsersGroupFeedTest < ActionDispatch::IntegrationTest
  test "should show user's feed when visiting group" do
    james = users(:james)
    michael = users(:michael)
    log_in_as(james)
    group_1 = groups(:group_1)
    james.befriend(michael)
    michael.add_to_group(group_1)
    michael.posts.create!(group_id: group_1.id, content: "Content")
    get user_group_path(user_id: james.slug, id: group_1.slug)
    assert_select "div#feed" do
      assert_select "li", 2
    end
  end
end
