class Lesson < ActiveRecord::Base
	attr_accessible :title, :description, :order_number

	validates :title, :presence => true
	validates :description, :presence => true

	default_scope order('order_number')
end