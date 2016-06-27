Rails.application.routes.draw do
  resources :tagfinder_executions, path: 'run', except: %i(new edit destroy)
  resources :documents,                         only:   %i(index create destroy)
  resources :users,                             only:   %i(index destroy update_attributes)

  root to: 'visitors#index'

  get '/admin'                   => 'admin#index',       as: :admin
  get '/admin/documents'         => 'admin#documents',   as: :all_documents
  get '/admin/executions'        => 'admin#executions',  as: :all_executions

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin'                  => 'sessions#new',      as: :signin
  get '/signout'                 => 'sessions#destroy',  as: :signout
  get '/auth/failure'            => 'sessions#failure'
end
