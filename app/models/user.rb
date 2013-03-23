class User < ActiveRecord::Base
  has_many :posts
  # devise modules: :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable
  validates :username, :presence => true
  validates :username, :uniqueness => { :case_sensitive => false }, :on => :create
  validates :password_confirmation, :presence => true, :on => :create

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :is_admin
end