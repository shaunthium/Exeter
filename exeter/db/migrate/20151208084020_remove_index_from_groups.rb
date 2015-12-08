class RemoveIndexFromGroups < ActiveRecord::Migration
  def change
      remove_column :groups, :id, :primary_key
  end
end
