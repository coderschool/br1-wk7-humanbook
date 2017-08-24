Rails.application.routes.draw do
  resources :comments
  post "likes" => "likes#toggle"

  get "wall/:id" => "wall#show", as: :wall

  resources :posts do
    get :paging, on: :collection
  end
  
  get 'friends/my'
  get 'friends/friended_by'
  get 'friends/search'

  resources "messages" do
    collection do
      get :inbox
      get :sent
    end
  end

  get "friends" => "friends#index"
  get "profile" => "users#edit"
  # NOTE: /auth/facebook is supported by the omniauth-facebook gem

  get 'auth/:provider/callback' => 'sessions#callback'

  delete "remove_friend" => "friendships#destroy"
  resources :friendships

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  resources :users do 
    collection do
      get :search
    end
  end

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
