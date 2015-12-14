class AddIdToGroups < ActiveRecord::Migration
  def change
      add_column :groups, :id, :primary_key
  end
end
