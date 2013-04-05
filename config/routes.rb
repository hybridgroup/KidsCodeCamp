KidsCodeCamp::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root :to => 'events#index'
  
  get 'about' => 'pages#about'
  get 'contact' => 'contact#new'
  post 'contact' => 'contact#create'

  # Devise
  devise_scope :user do
    match 'sign_up' => 'users/registrations#new'
    match 'login' => 'users/sessions#new'
    match 'logout' => 'users/sessions#destroy', :via => :delete
  end
  devise_for :users, :controllers => { :sessions => 'users/sessions', :registrations => 'users/registrations' }

  # Public
  resources :posts, :path => 'community' do
    #get ':category/:id' => 'posts#show', :on => :collection, :as => 'show', :constraints => { :category => /Discussion|General|Teachers/, :id => /[0-9]*/ }
    #get ':category' => 'posts#index', :on => :collection, :constraints => { :category => /[0-9]*/ }
  end
  scope :only => [:index, :show] do
    resources :users, :events
  end
end