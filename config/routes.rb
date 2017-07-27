Rails.application.routes.draw do
  resources :users
  resource :session, only:[:create, :destroy, :new]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "pages#index"
  get "/api/trends/:id", to: 'api/trends#show'
  get "/pages/:name", to: "pages#show"
  get "/api/news/:name", to: 'api/news#show'

  get "/history/new", to: "history#create"
  post "user/:id/history", to: "history#create"

end
