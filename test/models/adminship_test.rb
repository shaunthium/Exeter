require 'test_helper'

class AdminshipTest < ActiveSupport::TestCase
    def setup
        @one = adminships(:one)
    end

    test "should require admin id" do
        @one.admin_id = nil
        assert_not @one.valid?
    end

    test "should require administrated group id" do
        @one.administrated_group_id = nil
        assert_not @one.valid?
    end
end
