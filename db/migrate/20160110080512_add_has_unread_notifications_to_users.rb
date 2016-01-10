class AddHasUnreadNotificationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_unread_notifications, :boolean
  end
end
