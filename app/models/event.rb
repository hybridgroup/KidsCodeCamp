class Event < ActiveRecord::Base
  attr_accessible :content, :slug, :title
end
