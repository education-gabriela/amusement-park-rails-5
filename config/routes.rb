Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show]

  root "/", controller: "static", action: "index"

  get "/signin", controller: "sessions", action: "new"
  post "/signin", controller: "sessions", action: "create"

  get "/signup", controller: "users", action: "new"
end
