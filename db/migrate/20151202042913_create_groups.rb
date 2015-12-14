class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups, id: false do |t|
      t.integer :group_id
      t.string :name
      t.integer :member_id

      t.timestamps null: false
    end
    add_index :groups, :group_id
    add_index :groups, :member_id
  end
end
