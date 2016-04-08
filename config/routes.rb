Rails.application.routes.draw do
  resources :documents, only: %i(index create destroy)
  resources :users

  root to: 'visitors#index'

  get '/admin/metrics'           => 'admin#metrics',    as: :metrics

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin'                  => 'sessions#new',     as: :signin
  get '/signout'                 => 'sessions#destroy', as: :signout
  get '/auth/failure'            => 'sessions#failure'
end
