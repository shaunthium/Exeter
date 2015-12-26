require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
    def setup
        @james = users(:james)
        remember(@james)
    end

    test "current_logged_in_user returns correct user when session is nil" do
        assert_equal @james, current_logged_in_user
        assert logged_in?
    end

    test "current_logged_in_user returns nil when remember digest is wrong" do
        @james.update_attribute(:remember_digest, User.digest(User.new_token))
        assert_nil current_logged_in_user
    end
end
