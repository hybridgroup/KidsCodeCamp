KidsCodeCamp::Application.routes.draw do
  root :to => 'events#index'
  
  match 'sign_up' => 'users/registrations#new'
  match 'sing_in' => 'devise/sessions#new'
  match 'about' => 'pages#about'

  match 'contact' => 'contact_forms#new', :via => :get
  match 'contact' => 'contact_forms#create', :via => :post
  match 'admin' => 'admin/users#dashboard'

  # Devise
  devise_for :users, :controllers => { :registrations => 'users/registrations' }

  # Admin
  namespace :admin , :only => [:new, :create, :edit, :update, :destroy, :index ] do
    resources :posts, :events
    resources :users do
      get 'dashboard', :on => :collection
    end
  end
  
  # Public
  scope :only => [:index, :show] do
    resources :posts, :path => 'community'
    resources :users, :events
  end
end