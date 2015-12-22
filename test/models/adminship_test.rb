require 'test_helper'

class AdminshipTest < ActiveSupport::TestCase
    def setup
        @adminship_1 = adminships(:adminship_1)
    end

    test "should require admin id" do
        @adminship_1.admin_id = nil
        assert_not @adminship_1.valid?
    end

    test "should require administrated group id" do
        @adminship_1.administrated_group_id = nil
        assert_not @adminship_1.valid?
    end
end
