class NotificationsController < ApplicationController
  def update
    respond_to do |format|
      format.js {
        # current_logged_in_user.notifications.each do |notification|
        #   notification.update_attribute(:read, true) unless notification.read
        # end
        current_logged_in_user.update_attribute(:has_unread_notifications, false)
      }
    end
  end
end
