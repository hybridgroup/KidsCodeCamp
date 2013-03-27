class Post < ActiveRecord::Base
  validates :category, :inclusion => { :in => %w(General Discussion Teachers) }, :allow_nil => true
  validates :title, :content, :category, :presence => true
  attr_accessible :content, :slug, :title, :user_id, :parent_id, :category
  belongs_to :user

  # Rails Admin
  rails_admin do
    list do
      exclude_fields :slug
    end
    edit do
      configure :user do
        visible false
      end
      configure :user_id, :hidden do
        visible true
        default_value do
          bindings[:view]._current_user.id if value.blank?
        end
      end
      exclude_fields :created_at, :updated_at, :slug, :parent_id
    end
  end

  # RailsAdmin Enum
  def category_enum
    %w(General Discussion Teachers)
  end
end