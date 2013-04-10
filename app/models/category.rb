class Category < ActiveRecord::Base
  attr_accessible :title, :slug, :description
  
  has_many :posts
  has_many :responses, :through => :posts

  validates :title, :length => { :in => 2..100 }, :presence => true
  validates :description, :presence => true

  extend FriendlyId
  friendly_id :title, :use => :slugged

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
      field :title
      field :description
      field :created_at
      field :updated_at
    end
    #=-=-=-=-=-=-=-=-=-=-
    edit do
      field :title
      field :description
    end
  end
end