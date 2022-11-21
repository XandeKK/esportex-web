Rails.application.routes.draw do
  root to: redirect('/home')
	
  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resource :session, controller: 'clearance/sessions', only: [:create]

  resources :users, controller: 'users', only: [:create] do
    resource :password,
      controller: 'clearance/passwords',
      only: [:edit, :update]
  end

  get '/sign_in', to: 'clearance/sessions#new', as: 'sign_in'
  delete '/sign_out', to: 'clearance/sessions#destroy', as: 'sign_out'
  get '/sign_up', to: 'users#new', as: 'sign_up'

  get '/home', to: 'home#index'

  get '/sport', to: redirect('/sports')
  get '/sports', to: 'sports#index'

  resources :games, path: '/sports/:sport/games', except: [:new, :create]
  get "/sport/games/new", to: "games#new", as: "new_game"
  post "/sport/games", to: "games#create", as: "create_game"


  resources :profiles, path: "/", only: [:show, :edit, :update]
end
