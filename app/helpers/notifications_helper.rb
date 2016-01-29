module NotificationsHelper
  # Notify all members of the group except the user who posted the content
  def notify_members_of_group(group, action)
    user = current_logged_in_user.name
    group.members.each do |member|
      unless current_logged_in_user_is?(member)
        group_name = group.name
        content = "#{user} just #{action} in #{group_name}!"
        member.notifications.create!(content: content)
        # Set member to currently have unread notifications
        member.update_attribute(:has_unread_notifications, true) unless member.has_unread_notifications
      end
    end
  end
end
