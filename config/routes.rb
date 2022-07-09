Rails.application.routes.draw do
  get 'sign_up', to: 'registration#new'
  post 'sign_up', to: 'registration#create'
  
  get 'login', to: 'session#new'
  post 'login', to: 'session#create'
  delete 'logout', to: 'session#destroy'

  get 'password_resets', to: 'password_resets#new'
  post 'password_resets', to: 'password_resets#create'
  get 'password_resets/edit/:token', to: 'password_resets#edit', as: 'password_resets_edit'
  put 'password_resets/edit/:token', to: 'password_resets#update', as: 'password_resets_update'

  get '/:profile', to: 'profile#show', as: 'profile'
  get '/edit/profile', to: 'profile#edit', as: 'edit_profile'
  put '/edit/profile', to: 'profile#update', as: 'update_profile'
  delete 'destroy/user', to: 'profile#destroy', as: 'destroy_user'

  root 'sport#index'

  get 'games/:sport', to: 'game#index', as: 'games'
  get 'game/:id', to: 'game#show', as: 'game'
  get 'new/game', to: 'game#new', as: 'new_game'
  post 'new/game', to: 'game#create', as: 'create_game'
  get 'edit/game/:id', to: 'game#edit', as: 'edit_game'
  put 'edit/game/:id', to: 'game#update', as: 'update_game'
  delete 'destroy/game/:id', to: 'game#destroy', as: 'destroy_game'

  get 'map/games', to: 'map#show'
end
