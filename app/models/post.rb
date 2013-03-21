class Post < ActiveRecord::Base
  attr_accessible :content, :slug, :title, :user_id, :parent_id
  belongs_to :user
end
