class Rename < ActiveRecord::Migration
  change_table :posts do |t|
    t.rename :counter_cache, :impressions_count
  end
end