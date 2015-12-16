class AddSlugToGroups < ActiveRecord::Migration
  def change
      add_column :groups, :slug, :string, unique: true, index: true
  end
end
