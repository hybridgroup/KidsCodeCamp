class Board < ActiveRecord::Base
  attr_accessible :name

  has_ancestry
  has_many :posts
end
