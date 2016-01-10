class AddReadStatusToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :read_status, :boolean, index: true, null: false, default: false
  end
end
