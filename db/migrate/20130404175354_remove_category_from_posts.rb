class RemoveCategoryFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :category
  end

  def down
    add_column :posts, :category, :string
  end
end
