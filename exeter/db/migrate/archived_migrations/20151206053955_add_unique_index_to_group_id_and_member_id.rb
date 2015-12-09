class AddUniqueIndexToGroupIdAndMemberId < ActiveRecord::Migration
  def change
      add_index :groups, [:group_id, :member_id], unique: true
  end
end
