class User < ActiveRecord::Base
  has_many :posts
  # devise modules: :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable
  validates :username, :presence => true
  validates :username, :uniqueness => { :case_sensitive => false }, :on => :create
  validates :password_confirmation, :presence => true, :on => :create

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :is_admin

  # Rails Admin
  rails_admin do
    configure :num_posts do
      label 'Posts'
      pretty_value do
        bindings[:object].posts.length
      end
      read_only true
    end
    configure :is_admin do
      label 'Admin?'
      pretty_value do
        if value
          'Yes'
        else
          'No'
        end
      end
    end
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    list do
      field :username
      field :email
      field :num_posts
      field :is_admin
      field :created_at
      field :updated_at
    end
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    show do
      field :username
      field :email
      field :is_admin
      field :created_at
      field :updated_at
    end
    #=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    edit do
      field :username
      field :email
      field :password
      field :password_confirmation
      field :is_admin
    end
  end
end