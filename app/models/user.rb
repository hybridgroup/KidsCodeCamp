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
    list do
      include_fields :username, :email, :is_admin, :created_at, :updated_at
      field :is_admin do
        pretty_value do
          value.zero? ? 'No' : 'Yes'
        end
      end
    end
    edit do
      include_fields :username, :email, :password, :password_confirmation
      field :is_admin, :boolean do
        label 'Admin?'
      end
    end
  end
end