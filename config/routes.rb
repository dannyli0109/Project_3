Rails.application.routes.draw do
  resources :users
  resource :session, only:[:create, :destroy, :new]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "pages#index"
  get "/api/trends/:id", to: 'api/trends#show'
  get "/pages/:name", to: "pages#show"
  get "/api/news/:name", to: 'api/news#show'

  get "/histories/:id/show", to: "histories#show"
  post "/user/:id/histories", to: "histories#create"
  get "/api/tweets", to: "api/tweets#index"

end
