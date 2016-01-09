require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def setup
    @notification_adam = notifications(:notification_adam)
  end

  test "content should not be blank" do
    @notification_adam.content = nil
    assert_not @notification_adam.valid?
  end
end
