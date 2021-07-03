Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products
  resources :orders
  resources :carts
  get '/profile' => 'users#show'
  get '/change_myinfo' => 'users#edit'
  patch '/change_myinfo' => 'users#update'
  get '/' => 'users#index'
  get '/error' => 'problems#index'
  get '/accept/:id' => 'problems#show'
  get '/decline/:id' => 'problems#edit'
  get '/complete/:id' => 'problems#new'
end
