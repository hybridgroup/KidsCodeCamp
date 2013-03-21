KidsCodeCamp::Application.routes.draw do
  root :to => 'events#index'
  
  match 'about' => 'pages#about'
  match 'contact' => 'contact_forms#new', :via => :get
  match 'contact' => 'contact_forms#create', :via => :post
  match 'admin' => 'admin/users#dashboard', :as => 'dashboard'

  # Devise
  devise_for :users do
    match 'sign_up' => 'devise/registrations#new'
    match 'sign_in' => 'devise/sessions#new'
  end

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
=begin
=end
end