KidsCodeCamp::Application.routes.draw do
  root :to => 'posts#index'
  resources :posts, :events
  namespace :admin do
    match '/' => 'users#index'
    resources :users
  end
  devise_for :users, :path_names => { :sign_in => "login", :sign_out => "logout" }, :path => "d"
  resources :users
end