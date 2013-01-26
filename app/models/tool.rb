class Tool < ActiveRecord::Base
	attr_accessible :name, :category_id

	validates :name, :presence => true

	belongs_to :category
end
