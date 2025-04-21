Rails.application.routes.draw do
  root "courses#index"
  get "about", to: "pages#about"
  get "courses/new", to: "courses#new"
  resources :students, except: [:destroy]
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
