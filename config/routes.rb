KidsCodeCamp::Application.routes.draw do
  root :to => 'posts#index'
  
  # Devise
  devise_for :users, :path_names => { :sign_in => "login", :sign_out => "logout" }, :path => "d"
  devise_scope :user do
    match "admin" => "devise/sessions#new"
  end

  # Admin
  namespace :admin , :only => [:new, :create, :edit, :update, :delete, :index ] do
    resources :users, :posts, :events
  end
  
  # Public
  scope :only => [:index, :show] do
    resources :users, :posts, :events
  end
end