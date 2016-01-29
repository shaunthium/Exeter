module NotificationsHelper
  def notify_members_of_group(group, action)
    group.members.each do |member|
      user = current_logged_in_user.name
      unless current_logged_in_user_is?(member)
        group_name = group.name
        content = "#{user} just #{action} in #{group_name}!"
        member.notifications.create!(content: content)
        member.update_attribute(:has_unread_notifications, true) unless member.has_unread_notifications
      end
    end
  end
end
