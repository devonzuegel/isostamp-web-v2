Rails.application.routes.draw do
  resources :documents, only: %i(index new create destroy)
  resources :users

  match "/uploads/documents/:id/:basename.:extension" => 'documents#download', via: :get


  root to: 'visitors#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin'                  => 'sessions#new',     as: :signin
  get '/signout'                 => 'sessions#destroy', as: :signout
  get '/auth/failure'            => 'sessions#failure'
end
