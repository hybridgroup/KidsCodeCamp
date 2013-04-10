class Editpage < ActiveRecord::Base
  attr_accessible :title, :content

  validates :content, :presence => true

 # Rails Admin
  rails_admin do
    label 'Pages'
    show do
      field :title
      field :content
    end
    #=-=-=-=-=-=-=-=-=-=-=-=-=-
    list do
      field :title
      field :content
      field :updated_at
    end
    #=-=-=-=-=-=-=-=-=-=-=-=-=-
    edit do
      field :title
      field :content do
        html_attributes rows: 15, cols: 80
      end

    end
    #=-=-=-=-=-=-=-=-=-=-=-=-=-
  end
end