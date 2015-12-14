require 'test_helper'
include MembershipsHelper

class MembershipTest < ActiveSupport::TestCase
    def setup
        @membership = Membership.new(group_id: 1, member_id: 1)
    end

    test "group id should be present" do
        @membership.group_id = nil
        assert_not @membership.valid?
    end

    test "member id should be present" do
        @membership.member_id = nil
        assert_not @membership.valid?
    end
end
