Rails.application.routes.draw do
  get 'sessions/new'

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  get "logout" => "sessions#destroy"
  resources :users

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
