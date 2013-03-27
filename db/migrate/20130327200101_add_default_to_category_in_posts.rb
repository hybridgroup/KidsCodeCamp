class AddDefaultToCategoryInPosts < ActiveRecord::Migration
  def up
    change_column :posts, :category, :string, :default => 'General'
  end

  def down
    change_column :posts, :category, :string, :default => nil
  end
end
