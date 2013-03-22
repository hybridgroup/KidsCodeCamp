class Post < ActiveRecord::Base
  validates_inclusion_of :category, :in => %w( General Discussion Teachers ), :allow_nil => true
  attr_accessible :content, :slug, :title, :user_id, :parent_id, :category
  belongs_to :user
end
