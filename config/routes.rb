KidsCodeCamp::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root :to => 'events#index'
  
  match 'about' => 'pages#about'
  match 'contact' => 'contact#new', :via => :get
  match 'contact' => 'contact#create', :via => :post

  # Devise
  devise_scope :user do
    match 'sign_up' => 'users/registrations#new'
    match 'login' => 'users/sessions#new'
    match 'logout' => 'users/sessions#destroy', :via => :delete
  end
  devise_for :users, :controllers => { :sessions => 'users/sessions', :registrations => 'users/registrations' }

  # Public
  resources :posts, :path => 'community' do
    match '' => 'posts#index', :via => :post, :on => :collection
    match ':category' => 'posts#index', :on => :collection, :via => :get, :constraints => { :category => /[A-Za-z]/ }
  end
  scope :only => [:index, :show] do
    resources :users, :events
  end
end