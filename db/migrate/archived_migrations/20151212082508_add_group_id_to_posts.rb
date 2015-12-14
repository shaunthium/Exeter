class AddGroupIdToPosts < ActiveRecord::Migration
  def change
      add_column :posts, :group_id, :integer, index: true
  end
end
