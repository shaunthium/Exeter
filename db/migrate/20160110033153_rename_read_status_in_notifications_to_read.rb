class RenameReadStatusInNotificationsToRead < ActiveRecord::Migration
  def change
    rename_column :notifications, :read_status, :read
  end
end
