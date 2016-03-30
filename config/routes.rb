Rails.application.routes.draw do
  get 'data'          => 'data#index'
  get 'data/new'      => 'data#new'
  get 'data/create'   => 'data#create'
  get 'data/destroy'  => 'data#destroy'

  resources :users
  root to: 'visitors#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin'                  => 'sessions#new',     as: :signin
  get '/signout'                 => 'sessions#destroy', as: :signout
  get '/auth/failure'            => 'sessions#failure'
end
