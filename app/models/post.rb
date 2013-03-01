class Post < ActiveRecord::Base
  attr_accessible :board_id, :body, :title, :user_id, :parent_id, :counter_cache
  is_impressionable :counter_cache => true
  acts_as_indexed :fields => [:body, :title]

  has_ancestry
  belongs_to :board
  belongs_to :user
end
