Rails.application.routes.draw do
	resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  get "/sign_in", to: "clearance/sessions#new", as: "sign_in"
  delete "/sign_out", to: "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up", to: "users#new", as: "sign_up"

  get "/home", to: "home#index"
  root to: redirect('/home')
end
