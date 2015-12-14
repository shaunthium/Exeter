class RemoveUnnecessaryColumnsAndIndexesFromGroups < ActiveRecord::Migration
  def change
      remove_index :groups, column: :group_id
      remove_index :groups, column: :member_id
      remove_index :groups, column: [:group_id, :member_id]
      remove_columns :groups, :group_id, :member_id
  end
end
