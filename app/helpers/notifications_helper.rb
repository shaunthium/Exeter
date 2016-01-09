module NotificationsHelper
  def notify_members_of_group(group, action)
    group.members.each do |member|
      unless current_logged_in_user_is?(member)
        user = current_logged_in_user.name
        group_name = group.name
        content = "#{user} just #{action} in #{group_name}!"
        member.notifications.create!(content: content)
      end
    end
  end
end
