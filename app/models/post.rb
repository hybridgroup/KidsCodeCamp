class Post < ActiveRecord::Base
  attr_accessible :title, :content, :slug, :user_id, :parent_id, :category_id

  belongs_to :user
  belongs_to :category
  belongs_to :topic, :class_name => 'Post', :foreign_key => 'parent_id'
  has_many :responses, :class_name => 'Post', :foreign_key => 'parent_id', :dependent => :destroy
  
  validates :title, :length => { :in => 2..100 }, :presence => true, :unless => :parent_id?
  validates :category, :presence => true, :unless => :parent_id?
  validates :content, :user_id, :presence => true

  extend FriendlyId
  friendly_id :title, :use => :slugged

  # Rails Admin
  rails_admin do
    show do
      field :category
      field :title
      field :content
      field :user
      field :created_at
      field :updated_at
    end
    #=-=-=-=-=-=-=-=-=-=-=-=-=-
    list do
      field :title
      field :category
      field :user
      field :created_at
      field :updated_at
    end
    #=-=-=-=-=-=-=-=-=-=-=-=-=-
    edit do
      field :title
      field :content do
        html_attributes rows: 15, cols: 80
      end

      field :category do
        visible do
          bindings[:object].parent_id.blank?
        end
      end

      field :user do
        visible false
      end

      field :user_id, :hidden do
        visible true
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end
    #=-=-=-=-=-=-=-=-=-=-=-=-=-
    update do
      configure :title do
        visible do
          bindings[:object].parent_id.blank?
        end
      end
    end
  end
end