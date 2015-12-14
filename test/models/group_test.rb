require 'test_helper'

class GroupTest < ActiveSupport::TestCase
    def setup
        @group_1 = groups(:group_1)
    end

    test "name should be present" do
        group = Group.new(name: "   ")
        assert_not group.valid?
    end

    test "associated group's posts should be destroyed" do
        @group_1.posts.create!(user_id: 1, content: "Some content here.")
        assert_difference "Post.count", -1 do
            @group_1.destroy
        end
    end

    test "associated group's memberships should be destroyed" do
        group = Group.create!(name: "Group")
        group.memberships.create!(member_id: 1)
        assert_difference "Membership.count", -1 do
            group.destroy
        end
    end
end
