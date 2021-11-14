Rails.application.routes.draw do
  
  #root to: 'users#new'
  root to: 'pages#index'

  get 'profil', to: 'users#edit', as: 'profil'

  patch '/profil', to: 'users#update'

  #session
  #get 'login', to: 'sessions#new', as: :new_session
  #get '/animaux/:slug', to: 'posts#species', as: :species_posts
  patch 'profil', to: 'users#update' 

  get '/login', to: 'session#new', as: :new_session
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :destroy_session

  resources :posts do
    collection do
      get 'me'
    end


  resources :passwords, only: [:new, :create, :edit, :update]
  resources :pets do
  resources :subscriptions, only: [:create, :destroy]
  end
  end
  resources :users, only: [:new, :create, :edit] do
    member do
      get 'confirm'
    end
  end


scope 'superadmin', module: 'admin', as: 'admin' do
  resources :species, exept: [:show]
end

  end




