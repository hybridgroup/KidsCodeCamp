class RemoveCategoryFromTools < ActiveRecord::Migration
  def up
  	remove_column :tools, :category
  end

  def down
  	add_column :tools, :category
  end
end
