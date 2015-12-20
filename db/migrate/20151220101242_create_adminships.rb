class CreateAdminships < ActiveRecord::Migration
  def change
    create_table :adminships do |t|
      t.integer :admin_id
      t.integer :administrated_group_id

      t.timestamps null: false
    end
    add_index :adminships, :admin_id
    add_index :adminships, :administrated_group_id
    add_index :adminships, [:admin_id, :administrated_group_id], unique: true
  end
end
