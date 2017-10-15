Rails.application.routes.draw do
  root to: 'top#index'
  resource :session, only: [:create, :destroy]
  get "/login", to: redirect("/auth/google")
  get "/logout", to: "sessions#destroy"
  get '/auth/google/callback', to: 'sessions#create'
end
