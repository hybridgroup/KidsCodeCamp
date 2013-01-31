class AddAncestryToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :ancestry, :string
    add_index :posts, :ancestry
    add_column :boards, :ancestry, :string
    add_index :boards, :ancestry
  end

  def self.down
    remove_index :posts, :ancestry
    remove_column :posts, :ancestry
    remove_index :boards, :ancestry
    remove_column :boards, :ancestry
  end
end
