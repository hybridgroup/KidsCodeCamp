class Add < ActiveRecord::Migration
  def change
    add_column :posts, :counter_cache, :integer
  end
end
