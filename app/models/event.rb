class Event < ActiveRecord::Base
  attr_accessible :content, :slug, :title

  validates :title, :length => { :in => 2..100 }, :presence => true
  validates :content, :presence => true

  extend FriendlyId
  friendly_id :title, :use => :slugged

  rails_admin do
    show do
      field :title
      field :content
      field :created_at
      field :updated_at
    end
    #=-=-=-=-=-=-=-=-=-=-
    list do
      field :title
      field :created_at
      field :updated_at
    end
    #=-=-=-=-=-=-=-=-=-=-
    edit do
      field :title
      field :content do
        html_attributes rows: 15, cols: 80
      end
    end
  end
end
