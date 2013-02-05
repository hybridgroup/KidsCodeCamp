class Post < ActiveRecord::Base
  attr_accessible :board_id, :body, :title, :user_id, :parent_id

  has_ancestry
  belongs_to :board
  belongs_to :user
end
