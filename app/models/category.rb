class Category < ActiveRecord::Base
  attr_accessible :title, :slug, :description
  
  has_many :posts

  validates :title, :length => { :in => 2..100 }, :presence => true
  validates :description, :presence => true


  # Rails Admin
  rails_admin do
    show do
      field :title
      field :description
      field :created_at
      field :updated_at
    end
    #=-=-=-=-=-=-=-=-=-=-
    list do
      include_fields :title, :description,:created_at, :updated_at
    end
    #=-=-=-=-=-=-=-=-=-=-
    edit do
      include_fields :title, :description
    end
  end
end