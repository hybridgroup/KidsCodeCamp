class Event < ActiveRecord::Base
  attr_accessible :content, :slug, :title
  
  rails_admin do
    list do
      field :title
      field :content
      field :created_at
      field :updated_at
    end
    edit do
      field :title
      field :content
    end
  end
end
