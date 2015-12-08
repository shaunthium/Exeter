class RemoveUniqueIndexOnGroupIdAndMemberIdFromGroups < ActiveRecord::Migration
  def change
      remove_index :groups, [:group_id, :member_id]
  end
end
