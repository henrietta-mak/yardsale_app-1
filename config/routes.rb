YardsalesApp::Application.routes.draw do
  resources :users do
    get :followed_yardsales
    get :comments
  end
  resources :sessions, :only => [:new, :create, :destroy]
  resources :resets,   :only => [:new, :create, :edit, :update]

  resources :yardsales do
    get :following_users
    resources :relationships, :only => [:create, :destroy]
    resources :categorising,  :only => [:create, :destroy]
    resources :images,        :only => [:create, :destroy]
    resources :comments,      :only => [:create, :destroy]
  end
  resources :categories, :only => [:index, :show, :destroy]
  resources :images,     :only => :index
  resources :comments,   :only => :index

  resources :maps, :only => [:index, :show]

  root :to => 'public_pages#home'

  match 'signup'  => 'users#new'
  match 'signin'  => 'sessions#new'
  match 'signout' => 'sessions#destroy', :via => :delete

  match 'search'  => 'public_pages#search'

  match 'help'    => 'public_pages#help'
  match 'about'   => 'public_pages#about'
  match 'contact' => 'public_pages#contact'
end
