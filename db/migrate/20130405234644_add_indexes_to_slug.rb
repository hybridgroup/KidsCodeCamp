class AddIndexesToSlug < ActiveRecord::Migration
  def up
    add_index :categories, :slug, :unique => true
    add_index :posts, :slug, :unique => true
    add_index :events, :slug, :unique => true
  end
  def remove
    remove_index :categories, :slug
    remove_index :posts, :slug
    remove_index :events, :slug
  end
end
