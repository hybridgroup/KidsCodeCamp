KidsCodeCamp::Application.routes.draw do
  root :to => 'posts#index'
  
  # Devise
  devise_for :users, :path_names => { :sign_in => "login", :sign_out => "logout" }, :path => "d", :controllers => { :registrations => "users/registrations" }
  devise_scope :user do
    match "admin" => "devise/users#dashboard"
  end

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