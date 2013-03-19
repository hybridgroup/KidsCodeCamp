KidsCodeCamp::Application.routes.draw do
  root :to => 'posts#index'
  match 'signup' => 'pages#signup'
  match 'about' => 'pages#about'

  match 'contact' => 'contact_forms#new', :via => :get
  match 'contact' => 'contact_forms#create', :via => :post
  match "admin" => "admin/users#dashboard"

  # Devise
  devise_for :users, :path_names => { :sign_in => "login", :sign_out => "logout" }, :path => "d", :controllers => { :registrations => "users/registrations" }

  # Admin
  namespace :admin , :only => [:new, :create, :edit, :update, :destroy, :index ] do
    resources :posts, :events
    resources :users do
      collection do
        get "dashboard"
      end
    end
  end
  
  # Public
  scope :only => [:index, :show] do
    resources :users, :posts, :events
  end
end